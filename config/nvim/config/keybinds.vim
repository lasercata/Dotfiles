"----------------------------------------
"
" Author        :   Lasercata
" Last update   :   2025.11.09
" Version       :   v1.3.9
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
vnoremap <leader>* <ESC>`<i*<ESC>`>la*<ESC>
vnoremap <leader>µ <ESC>`<i**<ESC>`>lla**<ESC>
vnoremap <leader>< <ESC>`<i<<ESC>`>la><ESC>

"---Spelling
" Correct the closer error behind cursor in insert mode.
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Toggle spell in normal mode
nnoremap <C-s> <cmd>set invspell<CR>

" next (j) and previous (k) spelling mistakes
nnoremap <leader>sj ]s
nnoremap <leader>sk [s

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

" Jump to last used buffer
nnoremap <leader>jo <cmd>b#<cr>

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

"---Remove search highlight
nnoremap <esc> <cmd>noh<cr>

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

nnoremap <silent> <leader>q <cmd>call ToggleQuickFix()<cr>
nnoremap <leader>n <cmd>cn<cr>
nnoremap <leader>p <cmd>cp<cr>

" nnoremap <leader>cc <cmd>call ToggleQuickFix()<cr>
" nnoremap <leader>cn <cmd>cn<cr>
" nnoremap <leader>cp <cmd>cp<cr>
" nnoremap <leader>ce <cmd>lua vim.diagnostic.setqflist()<cr>

"---Make
nnoremap <F5> <cmd>make<CR>

"---Arduino
nnoremap <leader>ac <cmd>!arduino-cli compile --fqbn arduino:avr:uno %<CR>
nnoremap <leader>au <cmd>!arduino-cli upload --fqbn arduino:avr:uno -p /dev/ttyACM0 %<CR>

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

vim.keymap.set('n', '<leader>cc', vim.diagnostic.open_float, { desc = 'Show diagnostic in a floating window' })
vim.keymap.set('n', '<leader>cq', vim.diagnostic.setqflist, { desc = 'Put all diagnostics in the quick fix' })
vim.keymap.set('n', '<leader>cn', vim.diagnostic.goto_next, { desc = 'goto the next diagnostic' })
vim.keymap.set('n', '<leader>cp', vim.diagnostic.goto_prev, { desc = 'goto the prev diagnostic' })
EOF
