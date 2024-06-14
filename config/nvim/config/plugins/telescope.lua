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
    '<leader>:',
    '<cmd>Telescope live_grep<cr>',
    {desc = 'Find in cwd (telescope)'}
)

vim.keymap.set(
    'n',
    '<leader>/',
    '<cmd>Telescope live_grep grep_open_files=true<cr>',
    {desc = 'Find in openned buffers (telescope)'}
)

vim.keymap.set(
    'n',
    '<leader>b',
    '<cmd>Telescope buffers<cr>',
    {desc = 'Open telescope for buffers'}
)
