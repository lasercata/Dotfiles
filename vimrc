"----------------------------------------
"
" Author        :   Lasercata
" Last update   :   2022.04.30
" Version       :   v3.0
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

"---Autoclose delimiters
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O

"---Other
filetype plugin indent on
syntax enable
set background=dark

set nu "Line numbers
set ruler "Show things at bottom right
set mouse=r
set nolist "Don't show '$' at the end of lines

nnoremap j gj
nnoremap k gk

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
    let maplocalleader = ","

call plug#end()
