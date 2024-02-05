require('nvim-tree').setup({
    renderer = {
        highlight_opened_files = 'name',
    },
})

vim.keymap.set(
    'n',
    '<leader>e',
    '<cmd>NvimTreeFindFileToggle<cr>',
    {desc = 'Toggle file explorer window'}
)
