"--------------------------------
"
" Author            : Lasercata
" Last modification : 2023.04.18
" Version           : v1.3
"
"--------------------------------


" Enable Mouse for scrolling
set mouse=n

" Neovide
let g:neovide_scale_factor = 0.65
let g:neovide_transparency = 0.8

" Set Editor Font
if exists(':GuiFont')
    " Use GuiFont! to ignore font errors
    GuiFont! Hack Nerd Font:h11
endif

" Disable GUI Tabline
if exists(':GuiTabline')
    GuiTabline 0
endif

" Disable GUI Popupmenu
if exists(':GuiPopupmenu')
    GuiPopupmenu 0
endif

" Disable GUI ScrollBar
if exists(':GuiScrollBar')
    GuiScrollBar 0
endif

" Right Click Context Menu (Copy-Cut-Paste)
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv

" Colors
"hi Statement guifg=#fdbc4b gui=none
"hi PreProc guifg=#5fd7ff
"hi Comment guifg=#16a085
"hi Special guifg=#fdd5d5
"hi Normal guifg=#1c1e1f guifg=#ffffff
"hi LineNr guifg=#f9b94a
"
"Now using the colorscheme 'nightfly'.

" File tree (CHADTree is way better (leader + e))
nnoremap <C-t> :GuiTreeviewToggle<CR>
