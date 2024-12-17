#!/usr/bin/env bash

#--------------------------------
#
# Last modification : 2024.12.17
# Author            : Lasercata
# Version           : v1.0.1
#
#--------------------------------

# Sources :
#   - https://github.com/jackielii/dotfiles/blob/main/.config/lf/preview
#   -


FILE_PATH="${1}" # Full path of the highlighted file
WIDTH="${2}"     # Width of the preview pane (number of fitting characters)
HEIGHT="${3}"    # Height of the preview pane (number of fitting characters)
X="${4}"         # X coordinate of the preview pane
Y="${5}"         # Y coordinate of the preview pane

if ! [ -f "$FILE_PATH" ] && ! [ -h "$FILE_PATH" ]; then
    exit
fi

FILE_EXTENSION="${FILE_PATH##*.}"
FILE_EXTENSION_LOWER="$(printf "%s" "${FILE_EXTENSION}" | tr '[:upper:]' '[:lower:]')"
MIME_TYPE="$(file --dereference --brief --mime-type -- "${FILE_PATH}")"

CACHE_PATH=$(printf '%s/.cache/lf' "$HOME")

# [ -n "$WIDTH" ] && [ -n "$HEIGHT" ] && [ -n "$X" ] && [ -n "$Y" ] || PAGE_MODE=$?
[ $# -gt 1 ] || PAGE_MODE=$?

hash() {
    # printf '%s/%s.jpg' "$CACHE_PATH" \
    # "$(md5sum "$(readlink -f "$1")" | awk '{print $1}')"
    echo "$CACHE_PATH"/"$(basename "$1")"_"$(stat -c '%Y' "$1")".jpg
}

handle_image() {
    ##**********************************************************************
    ## adopted from ranger scope.sh
    ## replace exit with return
    ##**********************************************************************

    ## Size of the preview if there are multiple options or it has to be
    ## rendered from vector graphics. If the conversion program allows
    ## specifying only one dimension while keeping the aspect ratio, the width
    ## will be used.
    local DEFAULT_SIZE
    DEFAULT_SIZE="1024x768"
    # DEFAULT_SIZE=$(kitty +kitten icat --print-window-size)
    # if [ -z "$DEFAULT_SIZE" ]; then
    #   DEFAULT_SIZE="1024x768"
    # fi

    case "${MIME_TYPE}" in
        ## SVG
        image/svg+xml | image/svg)
            rsvg-convert --keep-aspect-ratio --width "${DEFAULT_SIZE%x*}" "${FILE_PATH}" -o "${IMAGE_CACHE_PATH}.png" &&
            mv "${IMAGE_CACHE_PATH}.png" "${IMAGE_CACHE_PATH}" &&
            return 6
            return 1
        ;;

        # DjVu
        image/vnd.djvu)
            ddjvu -format=tiff -quality=90 -page=1 -size="${DEFAULT_SIZE}" \
                  - "${IMAGE_CACHE_PATH}" < "${FILE_PATH}" \
                  && return 6 || return 1;;

        ## Image
        image/*)
            local orientation
            orientation="$(identify -format '%[EXIF:Orientation]\n' -- "${FILE_PATH}")"
            ## If orientation data is present and the image actually
            ## needs rotating ("1" means no rotation)...
            if [[ -n "$orientation" && "$orientation" != 1 ]]; then
              ## ...auto-rotate the image according to the EXIF data.
              convert -- "${FILE_PATH}" -auto-orient "${IMAGE_CACHE_PATH}" && return 6
            fi

        return 7
        ;;

        ## Video
        video/*)
            # Get embedded thumbnail
            ffmpeg -i "${FILE_PATH}" -map 0:v -map -0:V -c copy "${IMAGE_CACHE_PATH}" && return 6
            # Get frame 10% into video
            ffmpegthumbnailer -i "${FILE_PATH}" -o "${IMAGE_CACHE_PATH}" -s 0 && return 6
            return 1
        ;;

        ## Audio
        audio/*)
            # Get embedded thumbnail
            ffmpeg -i "${FILE_PATH}" -map 0:v -map -0:V -c copy \
            "${IMAGE_CACHE_PATH}" && return 6
        ;;

        ## PDF
        application/pdf)
          pdftoppm -f 1 -l 1 \
              -scale-to-x "${DEFAULT_SIZE%x*}" \
              -scale-to-y -1 \
              -singlefile \
              -jpeg -tiffcompression jpeg \
              -- "${FILE_PATH}" "${IMAGE_CACHE_PATH%.*}" &&
              return 6 || return 1
        ;;

        ## ePub, MOBI, FB2 (using Calibre)
        # application/epub+zip|application/x-mobipocket-ebook|\
        # application/x-fictionbook+xml)
        #     # ePub (using https://github.com/marianosimone/epub-thumbnailer)
        #     epub-thumbnailer "${FILE_PATH}" "${IMAGE_CACHE_PATH}" \
        #         "${DEFAULT_SIZE%x*}" && return 6
        #     ebook-meta --get-cover="${IMAGE_CACHE_PATH}" -- "${FILE_PATH}" \
        #         >/dev/null && return 6
        #     return 1;;

        ## Font
        application/font* | application/*opentype)
            preview_png="/tmp/$(basename "${IMAGE_CACHE_PATH%.*}").png"
            # echo "$preview_png"
            if fontimage -o "${preview_png}" \
              --pixelsize "120" \
              --fontname \
              --pixelsize "80" \
              --text "  ABCDEFGHIJKLMNOPQRSTUVWXYZ  " \
              --text "  abcdefghijklmnopqrstuvwxyz  " \
              --text "  0123456789.:,;(*!?') ff fl fi ffi ffl  " \
              --text "  The quick brown fox jumps over the lazy dog.  " \
              "${FILE_PATH}"; then
                convert -- "${preview_png}" "${IMAGE_CACHE_PATH}" &&
                    rm "${preview_png}" &&
                    return 6
                        else
                            return 1
            fi
        ;;

    esac

    openscad_image() {
        TMPPNG="$(mktemp -t XXXXXX.png)"
        openscad --colorscheme="${OPENSCAD_COLORSCHEME}" \
            --imgsize="${OPENSCAD_IMGSIZE/x/,}" \
            -o "${TMPPNG}" "${1}"
        mv "${TMPPNG}" "${IMAGE_CACHE_PATH}"
    }

    case "${FILE_EXTENSION_LOWER}" in
        # 3D models
        # OpenSCAD only supports png image output, and ${IMAGE_CACHE_PATH}
        # is hardcoded as jpeg. So we make a tempfile.png and just
        # move/rename it to jpg. This works because image libraries are
        # smart enough to handle it.
        csg|scad)
            openscad_image "${FILE_PATH}" && return 6
        ;;
        3mf|amf|dxf|off|stl)
            openscad_image <(echo "import(\"${FILE_PATH}\");") && return 6
        ;;
        # drawio)
        #     /Applications/draw.io.app/Contents/MacOS/draw.io -x "${FILE_PATH}" -o "${IMAGE_CACHE_PATH}" \
        #     --width "${DEFAULT_SIZE%x*}" && return 6
        #     return 1
        # ;;
    esac
}

hold() {
    tput civis >/dev/tty 2>/dev/null # hide cursor
    read -n 1 -s -r
    # stty raw
    # dd bs=1 count=1 &>/dev/null
    # stty cooked
    tput cnorm >/dev/tty 2>/dev/null # show cursor
}

draw() {
    if [ "$PAGE_MODE" ]; then
        WIDTH=${lf_width:=$(tput cols)}
        HEIGHT=${lf_height:=$(tput lines)}
        X=0
        Y=0
    fi
    if [ -n "$TMUX" ]; then
        WIDTH=$((WIDTH - 1))
        HEIGHT=$((HEIGHT - 1))
    fi
    if [ "$PAGE_MODE" ]; then
        clear
        kitty +kitten icat --stdin no --transfer-mode memory --place "${WIDTH}x${HEIGHT}@${X}x${Y}" "$1" </dev/null >/dev/tty
        hold
        kitty +kitten icat --clear --stdin no --transfer-mode memory </dev/null >/dev/tty
    else
        # preview launched in preview mode
        kitty +kitten icat --stdin no --transfer-mode memory --place "${WIDTH}x${HEIGHT}@${X}x${Y}" "$1" </dev/null >/dev/tty
        exit 1 # needed for the preview to refresh
    fi
}

fallback() {
    echo '----- File Type Classification -----'
    file --dereference --brief -- "${FILE_PATH}"
    printf '\n'
    echo '----- Exif Data -----'
    exiftool "${FILE_PATH}"
}

show_image() {
    # check if cached file exists, if not, create it
    IMAGE_CACHE_PATH="$(hash "$FILE_PATH")" # Full path that should be used to cache image preview

    echo "$IMAGE_CACHE_PATH"

    if [ -f "$IMAGE_CACHE_PATH" ]; then
        image="$IMAGE_CACHE_PATH"
    else
        mkdir -p "$CACHE_PATH"
        handle_image "$FILE_PATH"
        case $? in
            0) ;;
            1) ;;
            2) ;;
            3) ;;
            4) ;;
            5) ;;
            6) image="$IMAGE_CACHE_PATH" ;;
            7) image="$FILE_PATH" ;;
        esac
    fi

    if [ -n "$image" ]; then
        draw "$image"
    else
        fallback
    fi
}

#------ Run
# case "$1" in
#     *.tar*) tar tf "$1";;
#     *.zip) unzip -l "$1";;
#     *.rar) unrar l "$1";;
#     *.7z) 7z l "$1";;
#     *.pdf) pdftotext "$1" -;;
#     *.odt) odt2txt "$1";;
#     # *.jpg|*.png|*.jpeg|*.gif|*.PNG|*.JPG|*.svg) exiftool "$1" | bat -p ;;
#     *.jpg|*.png|*.jpeg|*.gif|*.PNG|*.JPG|*.svg) show_image ;;
#     *) bat --color always -p "$1";;
# esac
case "${MIME_TYPE}" in
    *tar) tar tf "$1";;
    */gzip) tar tf "$1";;
    */zip) unzip -l "$1";;
    */rar) unrar l "$1";;
    *7z*) 7z l "$1";;
    # application/pdf) pdftotext "$1" -;;
    *opendocument*) odt2txt "$1";;
    image/* | video/* | font/* | application/pdf) show_image ;;
    text/*)
        case "$1" in
            *.md) CLICOLOR_FORCE=1 COLORTERM=truecolor glow -s dark "$1";;
            *) bat --color always -p "$1";;
        esac;;
    # text/*) bat --color always -p "$1";;
    *) fallback ;;
esac
