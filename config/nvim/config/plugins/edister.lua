vim.keymap.set(
    'n',
    '<Leader>g',
    function() require('edister').edit_register() end,
    {desc = 'prompt for a register to edit'}
)
