--=== Setup
require('gitsigns').setup()

--=== Bindings
vim.keymap.set(
    {'v', 'n'},
    '<leader>gh',
    '<cmd>Gitsigns stage_hunk<cr>',
    {desc = 'Stage the current selection'}
)

vim.keymap.set(
    'n',
    '<leader>gp',
    '<cmd>Gitsigns preview_hunk_inline<cr>',
    {desc = 'Show a preview of the changes (inline)'}
)
vim.keymap.set(
    'n',
    '<leader>gP',
    '<cmd>Gitsigns preview_hunk<cr>',
    {desc = 'Show a preview of the changes (popup)'}
)

vim.keymap.set(
    'n',
    '<leader>gj',
    '<cmd>Gitsigns nav_hunk next<cr>',
    {desc = 'Go to the next change'}
)
vim.keymap.set(
    'n',
    '<leader>gk',
    '<cmd>Gitsigns nav_hunk prev<cr>',
    {desc = 'Go to the previous change'}
)

vim.keymap.set(
    'n',
    '<leader>gb',
    '<cmd>Gitsigns blame_line<cr>',
    {desc = 'Show git blame for the current line'}
)
vim.keymap.set(
    'n',
    '<leader>gB',
    '<cmd>Gitsigns blame<cr>',
    {desc = 'Open blame window'}
)

vim.keymap.set(
    'n',
    '<leader>gq',
    '<cmd>Gitsigns setqflist target=all<cr>',
    {desc = 'Set the quick fix with changes list'}
)
