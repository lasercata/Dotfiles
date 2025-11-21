-------------------------------------------
-- 
--  Author        :   Lasercata
--  Last update   :   2025.03.31
--  Version       :   v1.0.6
-- 
-------------------------------------------

--========= Set up nvim-cmp.
-- From the readme.
local lspconfig = require'lspconfig'
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

vim.lsp.config('pyright', {
  capabilities = capabilities
})
vim.lsp.enable('pyright')

--========= C
vim.lsp.config('clangd', {
  capabilities = capabilities
})
vim.lsp.enable('clangd')

--========= OCaml
vim.lsp.config('ocamllsp', {
  capabilities = capabilities
})
vim.lsp.enable('ocamllsp')

--========= Bash
vim.lsp.config('bashls', {
  capabilities = capabilities
})
vim.lsp.enable('bashls')

--========= LaTeX
vim.lsp.config('texlab', {
  capabilities = capabilities
})
vim.lsp.enable('texlab')

--========= cmake
vim.lsp.config('cmake', {
  capabilities = capabilities
})
vim.lsp.enable('cmake')

--========= HTML
vim.lsp.config('html', {
  capabilities = capabilities
})
vim.lsp.enable('html')

--========= javascript
-- vim.lsp.config('tsserver', {
vim.lsp.config('ts_ls', {
  capabilities = capabilities
})
vim.lsp.enable('ts_ls')

--========= java
vim.lsp.config('jdtls', {
  capabilities = capabilities,
  cmd = {
      'jdtls',
      '-XX:+UseParallelGC',
      '-XX:GCTimeRatio=4',
      '-XX:AdaptiveSizePolicyWeight=90',
      '-Dsun.zip.disableMemoryMapping=true',
      '-Xmx1G',
      '-Xms100m'
  }
})
vim.lsp.enable('jdtls')

--========= sql
vim.lsp.config('sqlls', {
  capabilities = capabilities
})
vim.lsp.enable('sqlls')

--========= asm
vim.lsp.config('asm_lsp', {
  capabilities = capabilities,
  assembler = 'nasm',
  instruction_set = 'arm',
  filetypes = {'asm', 'nasm'}
})
vim.lsp.enable('asm_lsp')

--========= prolog
vim.lsp.config('prolog_ls', {
  capabilities = capabilities
})
vim.lsp.enable('prolog_ls')

--========= racket
vim.lsp.config('racket_langserver', {
  capabilities = capabilities
})
vim.lsp.enable('racket_langserver')

--========= arduino
vim.lsp.config('arduino_language_server', {
  cmd = {
    'arduino-language-server',
    '-clangd', '/usr/bin/clangd',
    '-cli', '/usr/bin/arduino-cli',
    '-cli-config', '~/.arduinoIDE/arduino-cli.yaml',
    '-fqbn', 'arduino:avr:uno',
  },
  capabilities = capabilities
})
vim.lsp.enable('arduino_language_server')

--========= racket
vim.lsp.config('rust_analyzer', {
  capabilities = capabilities
})
vim.lsp.enable('rust_analyzer')

--=========lsp_signature.nvim
require 'lsp_signature'.setup()


--========= Other
-- this is for diagnostics signs on the line number column
-- use this to beautify the plain E W signs to more fun ones

-- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " } 
-- for type, icon in pairs(signs) do
--     local hl = "DiagnosticSign" .. type
--     vim.fn.sign_define(hl, { text = icon, texthl= hl, numhl = hl })
--     -- print("Highlight Group: " .. hl)
--     -- vim.api.nvim_sign_define(hl, { text = icon, texthl = hl, numhl = hl })
-- end

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
  },
})

