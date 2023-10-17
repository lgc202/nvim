local tool = require("tool")
local which_key = require("which-key")
local map = tool.map
vim.g.mapleader = " "
vim.g.maplocalleader = " "

which_key.register({
    s = {
        -- 垂直分割窗口
        v = { ":vsp<CR>", "Vertically Split" },
        -- 水平分割窗口
        h = { ":sp<CR>", "Horizontally Split" },
        -- 关闭当前窗口
        c = { "<C-w>c", "Close Current Window" },
        -- 关闭其它窗口
        o = { "<C-w>o", "Close Other Window" },
    },
    -- 跳转窗口
    ["<C-h>"] = { "<C-w>h", "Left Window" },
    ["<C-l>"] = { "<C-w>l", "Right Window" },
    ["<C-j>"] = { "<C-w>j", "Down Window" },
    ["<C-k>"] = { "<C-w>k", "Up Window" },
    -- 调整窗口大小
    ["<C-Left>"] = { ":vertical resize -5<CR>", "Decrease Window Width" },
    ["<C-Right>"] = { ":vertical resize +5<CR>", "Increase Window Width" },
    ["<C-Down>"] = { ":horizontal resize -5<CR>", "Decrease Window Height" },
    ["<C-Up>"] = { ":horizontal resize +5<CR>", "Decrease Window Height" },
}, { prefix = "" })

which_key.register({
    -- 打开/关闭目录树
    e = { ":NvimTreeToggle<CR>", "File Explorer" },
    -- 保存
    w = { ":w<CR>", "Save" },
    -- 退出
    q = { ":q<CR>", "Quit" },
}, { prefix = "<leader>" })
