-------------------------------------------
-- 
--  Author        :   Lasercata
--  Last update   :   2024.01.17
--  Version       :   v1.0.4
-- 
-------------------------------------------

--========= Set up nvim-cmp.
-- From the readme.
local cmp = require'cmp'

cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

--=========Python
-- require'lspconfig'.pylsp.setup{}
-- require'lspconfig'.pyright.setup{}

require('lspconfig')['pyright'].setup {
  capabilities = capabilities
}

--========= C
require('lspconfig')['clangd'].setup {
  capabilities = capabilities
}

--========= OCaml
require('lspconfig')['ocamllsp'].setup {
  capabilities = capabilities
}

--========= Bash
require('lspconfig')['bashls'].setup {
  capabilities = capabilities
}

--========= LaTeX
require('lspconfig')['texlab'].setup {
  capabilities = capabilities
}

--========= cmake
require('lspconfig')['cmake'].setup {
  capabilities = capabilities
}

--========= HTML
require('lspconfig')['html'].setup {
  capabilities = capabilities
}

--========= javascript
require('lspconfig')['tsserver'].setup {
  capabilities = capabilities
}

--========= java
require('lspconfig')['jdtls'].setup {
  capabilities = capabilities
}

--=========lsp_signature.nvim
require 'lsp_signature'.setup()


--========= Other
-- this is for diagnositcs signs on the line number column
-- use this to beautify the plain E W signs to more fun ones
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " } 
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl= hl, numhl = hl })
end
