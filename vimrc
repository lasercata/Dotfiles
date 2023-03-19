"----------------------------------------
"
" Author        :   Lasercata
" Last update   :   2023.03.19
" Version       :   v3.4
"
"----------------------------------------

"---Tabulations
set tabstop=4       " number of visual spaces per tab
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for auto indent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line

"---Search
set incsearch "Search as char entered
set hlsearch " Highlight matches

"---Auto close delimiters (done with snippets, see all.snippets)
"inoremap " ""<left>
"inoremap ' ''<left>
"inoremap ( ()<left>
"inoremap [ []<left>
"inoremap { {}<left>
"inoremap {<CR> {<CR>}<ESC>O

"---Spelling
setlocal spell
set spelllang=en_us,fr
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

"---Other
filetype plugin indent on
syntax enable
set background=dark

set nu "Line numbers
set ruler "Show things at bottom right
set mouse=r
set nolist "Don't show '$' at the end of lines

"---Remapping
"-Escape from insert mode
inoremap jk <esc>
inoremap kj <esc>

"-Shift + tab in insert mode does the opposite of tab.
inoremap <S-Tab> <C-d>

"-In visual mode, i indents selection, I remove one indentation, and both reselct the selection
vnoremap i >gv
vnoremap I <gv

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
    let maplocalleader = ","

"-Vim-Slime (for ocaml)
"Plug 'jpalardy/vim-slime'
    "let g:slime_target = "tmux"
    "let g:slime_paste_file = "$HOME/.slime_paste"

"-Nerd tree
Plug 'scrooloose/nerdtree'
    "let NERDTreeShowHidden=1

call plug#end()
