vim.keymap.set(
    'n',
    '<leader>m',
    '<cmd>lua require("harpoon.mark").add_file()<cr>',
    {desc = 'Mark current file for harpoon'}
)
vim.keymap.set(
    'n',
    '<leader>h',
    '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>',
    {desc = 'Toggle harpoon menu'}
)
vim.keymap.set(
    'n',
    '<leader>jj',
    '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>',
    {desc = 'Toggle harpoon menu'}
)

vim.keymap.set(
    'n',
    '<M-j>',
    '<cmd>lua require("harpoon.ui").nav_next()<CR>',
    {desc = 'Go to next harpoon file'}
)
vim.keymap.set(
    'n',
    '<M-k>',
    '<cmd>lua require("harpoon.ui").nav_prev()<CR>',
    {desc = 'Go to previous harpoon file'}
)

vim.keymap.set(
    'n',
    '<leader>&',
    '<cmd>lua require("harpoon.ui").nav_file(1)<CR>',
    {desc = 'Go to harpoon file 1'}
)
vim.keymap.set(
    'n',
    '<leader>é',
    '<cmd>lua require("harpoon.ui").nav_file(2)<CR>',
    {desc = 'Go to harpoon file 2'}
)
vim.keymap.set(
    'n',
    '<leader>"',
    '<cmd>lua require("harpoon.ui").nav_file(3)<CR>',
    {desc = 'Go to harpoon file 3'}
)
vim.keymap.set(
    'n',
    "<leader>'",
    '<cmd>lua require("harpoon.ui").nav_file(4)<CR>',
    {desc = 'Go to harpoon file 4'}
)

vim.keymap.set(
    'n',
    '<leader>jf',
    '<cmd>lua require("harpoon.ui").nav_file(1)<CR>',
    {desc = 'Go to harpoon file 1'}
)
vim.keymap.set(
    'n',
    '<leader>jd',
    '<cmd>lua require("harpoon.ui").nav_file(2)<CR>',
    {desc = 'Go to harpoon file 2'}
)
vim.keymap.set(
    'n',
    '<leader>js',
    '<cmd>lua require("harpoon.ui").nav_file(3)<CR>',
    {desc = 'Go to harpoon file 3'}
)
vim.keymap.set(
    'n',
    '<leader>jq',
    '<cmd>lua require("harpoon.ui").nav_file(4)<CR>',
    {desc = 'Go to harpoon file 4'}
)
