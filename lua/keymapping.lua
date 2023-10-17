local tool = require("tool")
local which_key = require("which-key")
local map = tool.map
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- map("n", "<leader>e", ":NvimTreeToggle<CR>")
which_key.register({
    -- 打开/关闭目录树
    e = { ":NvimTreeToggle<CR>", "File Explorer" },
    -- 保存
    w = { ":w<CR>", "Save" },
    -- 退出
    q = { ":q<CR>", "Quit" },
}, { prefix = "<leader>" })
