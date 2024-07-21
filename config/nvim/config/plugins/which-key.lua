--=== Setup
-- require('which-key').setup(
--     {
--         win = {
--             winblend = 20
--         }
--     }
-- )

--=== Bindings
vim.keymap.set(
    'n',
    '<leader>w',
    '<cmd>WhichKey<cr>',
    {desc = 'Show all mappings'}
)
