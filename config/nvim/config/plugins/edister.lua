--=== Bindings
vim.keymap.set(
    'n',
    '<Leader>r',
    function() require('edister').edit_register() end,
    {desc = 'prompt for a register to edit'}
)
