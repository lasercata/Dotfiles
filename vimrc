"----------------------------------------
"
" Author        :   Lasercata
" Last update   :   2021.05.14
" Version       :   v2.1
"
"----------------------------------------

"---Tabulations
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line

"---Search
set incsearch "Search as char entered
set hlsearch " Highlight matches

"---Other
syntax on
set background=dark

filetype on
set nu "Line numbers
set ruler "Show things at bottom right
set mouse=r
set nolist

nnoremap j gj
nnoremap k gk

