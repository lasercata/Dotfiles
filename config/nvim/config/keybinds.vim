"----------------------------------------
"
" Author        :   Lasercata
" Last update   :   2023.05.12
" Version       :   v1.2
"
"----------------------------------------


"---Leader keys
let mapleader = " "
nmap <space> <nop>
let maplocalleader = ","

"---Escape from insert mode
inoremap jk <esc>
inoremap kj <esc>

"---Also from terminal
tnoremap <ESC> <C-\><C-n>

"---Deleting in insert mode (with C-h, C-w) starts a new undo sequence
inoremap <C-h> <C-g>u<C-h>
inoremap <C-w> <C-g>u<C-w>

"---Auto close delimiters (now using pear-tree extension)
"inoremap " ""<left>
"inoremap ' ''<left>
"inoremap ( ()<left>
"inoremap [ []<left>
"inoremap { {}<left>
"inoremap {<CR> {<CR>}<ESC>O

"---Wrap selection with a delimiter (in visual mode)
vnoremap ( <ESC>`>a)<ESC>`<i(<ESC>%
vnoremap [ <ESC>`>a]<ESC>`<i[<ESC>%
vnoremap { <ESC>`<i{<ESC>`>la}<ESC>
vnoremap <leader>" <ESC>`<i"<ESC>`>la"<ESC>
vnoremap <leader>' <ESC>`<i'<ESC>`>la'<ESC>

"---Deleting surrounding delimiter (any that is detected with %) in normal mode.
"The cursor can be anywhere inside the delimiter pair.
nnoremap <leader>ds %v%<ESC>x`<x`>

"---Change window
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

"Also from terminal
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
tnoremap <C-h> <C-\><C-n><C-w>h

"---Change buffer faster
nnoremap <C-n> <cmd>bn<CR>
nnoremap <C-p> <cmd>bp<CR>

"---Change tab faster
nnoremap <M-n> gt
nnoremap <M-p> gT

"---Move cursor in insert and command mode : Alt + [hjkl$_]
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-l> <Right>
inoremap <M-h> <Left>
inoremap <M-$> <End>
inoremap <M-_> <Home>

cnoremap <M-j> <Down>
cnoremap <M-k> <Up>
cnoremap <M-l> <Right>
cnoremap <M-h> <Left>
cnoremap <M-$> <End>
cnoremap <M-_> <Home>

"---In visual mode, <leader>i indents selection, <leader>I decrease indentation, and both reselect the selection
vnoremap <leader>i >gv4l
vnoremap <leader>I <gv4h

"Also from normal mode
nnoremap <leader>i >>4l
nnoremap <leader>I <<4h

"---Toggle relative line
nnoremap <leader>n <cmd>set invrelativenumber<CR>

"---Make
nnoremap <F5> <cmd>make<CR>
