-------------------------------------------
-- 
--  Author        :   Lasercata
--  Last update   :   2023.08.22
--  Version       :   v1.0.0
-- 
-------------------------------------------

--===Python console
local fterm = require('FTerm')

local py = fterm:new({
    ft = 'fterm_py',
    cmd = 'python3'
})

vim.keymap.set({'n', 't'}, '<A-m>',
    function()
        py:toggle()
    end
)

--===Btop
local btop = fterm:new({
    ft = 'fterm_btop',
    cmd = "btop"
})

vim.keymap.set({'n', 't'}, '<A-b>',
    function()
        btop:toggle()
    end
)
