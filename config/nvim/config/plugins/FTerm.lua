-------------------------------------------
-- 
--  Author        :   Lasercata
--  Last update   :   2023.08.22
--  Version       :   v1.0.0
-- 
-------------------------------------------

--===Bindings
vim.keymap.set(
    'n',
    '<M-i>',
    '<cmd>lua require("FTerm").toggle()<cr>',
    {desc = 'Toggle floating terminal'}
)
vim.keymap.set(
    't',
    '<M-i>',
    '<C-\\><C-n><cmd>lua require("FTerm").toggle()<cr>',
    {desc = 'Toggle floating terminal'}
)


--===Python console
local fterm = require('FTerm')

local py = fterm:new({
    ft = 'fterm_py',
    cmd = 'python3'
})

vim.keymap.set({'n', 't'}, '<A-m>',
    function()
        py:toggle()
    end,
    {desc = 'Toggle python console'}
)

--===Btop
local btop = fterm:new({
    ft = 'fterm_btop',
    cmd = "btop"
})

vim.keymap.set({'n', 't'}, '<A-b>',
    function()
        btop:toggle()
    end,
    {desc = 'Toggle btop'}
)
