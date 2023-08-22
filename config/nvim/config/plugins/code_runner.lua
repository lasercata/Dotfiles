--=== Bindings
vim.keymap.set(
    'n',
    '<leader>r',
    '<cmd>RunCode<cr>',
    {desc = 'Run the current file'}
)

--=== Setup
require('code_runner').setup({
    filetype = {
        python = "python3 -u",
        ocaml = "ocaml",
    },
})
