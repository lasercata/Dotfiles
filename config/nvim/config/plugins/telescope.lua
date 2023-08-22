--=== Bindings
vim.keymap.set(
    'n',
    '<leader>F',
    '<cmd>Telescope find_files<cr>',
    {desc = 'Open telescope for files'}
)

vim.keymap.set(
    'n',
    '<leader>f',
'<cmd>Telescope oldfiles<cr>',
    {desc = 'Open telescope for recent files'}
)

vim.keymap.set(
    'n',
    '<leader>/',
    '<cmd>Telescope current_buffer_fuzzy_find<cr>',
    {desc = 'Fuzzy find (telescope)'}
)

vim.keymap.set(
    'n',
    '<leader>b',
    '<cmd>Telescope buffers<cr>',
    {desc = 'Open telescope for buffers'}
)
