"----------------------------------------
"
" Author        :   Lasercata
" Last update   :   2024.11.30
" Version       :   v1.3.3
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

set breakindent            " Add indentation to wrapped lines.
set breakindentopt=shift:1 " Wrapped lines will have one more space.
set linebreak              " Wrap on word (not in the middle of a word)

"---For OCaml
autocmd FileType ocaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 textwidth=79

"---For Racket
autocmd FileType racket setlocal tabstop=2 softtabstop=2 shiftwidth=2

"------Syntax
filetype plugin indent on "Enable file type detection, indent for the detected file type, and use the plugin for it.
syntax enable             "Enable syntax highlighting


"------Appearance
set background=dark
set nu             " Line numbers
set relativenumber " Relative line number to current position
set ruler          " Show things at bottom right
set list           " Needed for the plugin 'indent_blankline'
set listchars=trail:-
set mouse=r
set scrolloff=3

set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20 "Cursor shape in different modes, see :h guicursor


"------Search
set incsearch  "Search as char entered
set hlsearch   "Highlight matches
set ignorecase "Ignore the case of normal letters in search
set smartcase  "Overwrite ignorecase if there is an uppercase character in the searched text


"------Spelling
setlocal spell
set spelllang=en_gb,fr,it

" Correct the closer error behind cursor in insert mode.
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Toggle spell in normal mode
nnoremap <C-s> <cmd>set invspell<CR>


"------Folds
"---Python
autocmd FileType python setlocal foldnestmax=2 foldmethod=indent

"---C
autocmd FileType c setlocal foldnestmax=1 foldmethod=indent

"---LaTeX
autocmd FileType tex setlocal foldnestmax=3 foldmethod=indent foldlevelstart=1 foldlevel=1

"---JS
autocmd FileType javascript setlocal foldnestmax=1 foldmethod=indent

"---Java
autocmd FileType java setlocal foldnestmax=2 foldmethod=indent foldlevel=1

"---Markdown
let g:markdown_folding = 1
autocmd FileType markdown setlocal foldlevel=1

"---SQL
autocmd FileType sql setlocal foldmethod=indent foldnestmax=2

"---VueJS
autocmd FileType vue setlocal foldmethod=indent foldnestmax=1


"------Assembly syntax
augroup asm_syntax
    autocmd!
    autocmd BufReadPost *.s let b:asmsyntax = 'nasm'
augroup END
