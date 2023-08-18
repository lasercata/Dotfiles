"----------------------------------------
"
" Author        :   Lasercata
" Last update   :   2023.08.16
" Version       :   v1.1
"
"----------------------------------------


"------Tabulations
"---For all files
set tabstop=4              " number of visual spaces per tab
set softtabstop=4          " number of spaces in tab when editing
set shiftwidth=4           " number of spaces to use for auto indent
set expandtab              " tabs are space
set autoindent
set copyindent             " copy indent from the previous line

set breakindent            "Add indentation to wrapped lines.
set breakindentopt=shift:1 "Wrapped lines will have one more space.

"---For OCaml
autocmd FileType ocaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 textwidth=79

"------Syntax
filetype plugin indent on "Enable file type detection, indent for the detected file type, and use the plugin for it.
syntax enable             "Enable syntax highlighting


"------Appearance
set background=dark
set nu             "Line numbers
set relativenumber "Relative line number to current position
set ruler          "Show things at bottom right
set nolist         "Don't show '$' at the end of lines
set mouse=r
set scrolloff=3


"------Search
set incsearch  "Search as char entered
set hlsearch   "Highlight matches
set ignorecase "Ignore the case of normal letters in search
set smartcase  "Overwrite ignorecase if there is an uppercase character in the searched text


"------Spelling
setlocal spell
set spelllang=en_us,fr

" Correct the closer error behind cursor in insert mode.
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Toggle spell in normal mode
nnoremap <C-s> <cmd>set invspell<CR>


"------Folds
"---Python
autocmd FileType python setlocal foldnestmax=2 foldmethod=indent

