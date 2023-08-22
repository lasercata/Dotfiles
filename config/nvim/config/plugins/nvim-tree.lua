require('nvim-tree').setup()

vim.keymap.set(
    'n',
    '<leader>e',
    '<cmd>NvimTreeFindFileToggle<cr>',
    {desc = 'Toggle file explorer window'}
)
