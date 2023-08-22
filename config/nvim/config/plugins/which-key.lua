--=== Setup
require('which-key').setup(
    {
        window = {
            winblend = 20
        }
    }
)

--=== Bindings
vim.keymap.set(
    'n',
    '<leader>w',
    '<cmd>WhichKey<cr>',
    {desc = 'Show all mappings'}
)
