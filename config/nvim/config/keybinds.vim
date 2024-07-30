"----------------------------------------
"
" Author        :   Lasercata
" Last update   :   2024.07.21
" Version       :   v1.3.4
"
"----------------------------------------


"---Leader keys
let mapleader = " "
nmap <space> <nop>
let maplocalleader = " "
" let maplocalleader = ","

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
vnoremap ( <ESC>`>a)<ESC>`<i(<ESC>
vnoremap [ <ESC>`>a]<ESC>`<i[<ESC>
vnoremap { <ESC>`<i{<ESC>`>la}<ESC>%
vnoremap <leader>" <ESC>`<i"<ESC>`>la"<ESC>
vnoremap <leader>' <ESC>`<i'<ESC>`>la'<ESC>
vnoremap <leader>` <ESC>`<i`<ESC>`>la`<ESC>

"---Space around a char
nnoremap <space><space> i <esc>la <esc>

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
" nnoremap <leader>n <cmd>set invrelativenumber<CR>

"---Quickfix window
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

nnoremap <leader>n <cmd>cn<cr>
nnoremap <leader>p <cmd>cp<cr>

" nnoremap <leader>c <cmd>ccl<cr>
nnoremap <silent> <leader>q <cmd>call ToggleQuickFix()<cr>

"---Make
nnoremap <F5> <cmd>make<CR>

"---xxd
nnoremap <leader>x <cmd>%!xxd<cr><cmd>set ft=xxd<cr>
nnoremap <leader>X <cmd>%!xxd -r<cr>

"---LSP
lua << EOF
-- vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, bufopts)
-- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, { desc = 'Show signature' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
-- vim.keymap.set('n', '<space>K', vim.lsp.buf.signature_help, bufopts)
vim.keymap.set('n', '<leader>t', vim.lsp.buf.type_definition, { desc = 'Go to type definition' })
vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, { desc = 'Rename' })
EOF
