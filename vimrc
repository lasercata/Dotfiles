"----------------------------------------
"
" Author        :   Lasercata
" Last update   :   2023.03.31
" Version       :   v3.8
"
"----------------------------------------

"---Tabulations
set tabstop=4       " number of visual spaces per tab
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for auto indent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line

"---Syntax
filetype plugin indent on "Enable file type detection, indent for the detected file type, and use the plugin for it.
syntax enable             "Enable syntax highlighting
set background=dark

"---Appearance
set nu     "Line numbers
set ruler  "Show things at bottom right
set mouse=r
set nolist "Don't show '$' at the end of lines

"---Search
set incsearch  "Search as char entered
set hlsearch   "Highlight matches
set ignorecase "Ignore the case of normal letters in search
set smartcase  "Overwrite ignorecase if there is an uppercase character in the searched text

"---Spelling
setlocal spell
set spelllang=en_us,fr
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

"---Mappings
"-Leader key
let mapleader = " "
let maplocalleader = ","

"-Escape from insert mode
inoremap jk <esc>
inoremap kj <esc>

"-Auto close delimiters (now using pear-tree extension)
"inoremap " ""<left>
"inoremap ' ''<left>
"inoremap ( ()<left>
"inoremap [ []<left>
"inoremap { {}<left>
"inoremap {<CR> {<CR>}<ESC>O

"-Wrap selection with a delimiter (in visual mode)
vnoremap ( <ESC>`>a)<ESC>`<i(<ESC>%
vnoremap [ <ESC>`>a]<ESC>`<i[<ESC>%
vnoremap { <ESC>`>a}<ESC>`<i{<ESC>%

"-Deleting surrounding delimiter (any that is detected with %) in normal mode.
"The cursor can be anywhere inside the delimiter pair.
nnoremap <leader>ds %v%<ESC>x`<x`>

"-Change window
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

"-In visual mode, <leader>i indents selection, <leader>I decrease indentation, and both reselect the selection
vnoremap <leader>i >gv
vnoremap <leader>I <gv

"-Remap for plugins
nnoremap <C-t> :NERDTreeToggle<CR>
"autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif


"---Plugins
call plug#begin('~/.config/nvim/plugged')

"-UltiSnips snippets
Plug 'sirver/ultisnips'
    let g:UltiSnipsExpandTrigger = '<tab>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
    "let g:UltiSnipsSnippetDirectories = '~/.config/nvim/my_snippets/UltiSnips'
    let g:UltiSnipsSnippetDirectories=["UltiSnips", "my_snippets"]

"-Vimtex
Plug 'lervag/vimtex'
    let g:vimtex_view_method = 'zathura'

"-Vim-Slime (for ocaml)
"Plug 'jpalardy/vim-slime'
    "let g:slime_target = "tmux"
    "let g:slime_paste_file = "$HOME/.slime_paste"

"-Nerd tree
Plug 'scrooloose/nerdtree'
    "let NERDTreeShowHidden=1

"-Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_powerline_fonts = 1

"-Tmuxline
Plug 'edkolev/tmuxline.vim'
    let g:airline#extensions#tmuxline#enabled = 1
    let airline#extensions#tmuxline#snapshot_file = "~/.tmux-status.conf"

"-Pear-tree
Plug 'tmsvg/pear-tree'
    let g:pear_tree_smart_openers = 1
    let g:pear_tree_smart_closers = 1
    let g:pear_tree_smart_backspace = 1
    let g:pear_tree_repeatable_expand = 0

call plug#end()
