vim.keymap.set(
    'n',
    '<leader>f',
    '<cmd>Telescope find_files<cr>',
    {desc = 'Open telescope for files'}
)

vim.keymap.set(
    'n',
    '<leader>b',
    '<cmd>Telescope buffers<cr>',
    {desc = 'Open telescope for buffers'}
)
