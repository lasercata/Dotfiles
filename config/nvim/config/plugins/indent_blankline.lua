-- require('indent_blankline').setup()
require('ibl').setup({
    exclude = {
        buftypes = { 'terminal' },
        filetypes = { 'dashboard', 'NvimTree', 'packer', 'lsp-installer' }
    },
    scope = {
        enabled = true,
        show_end = true
    }
})
