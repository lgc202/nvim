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

    -- LSP 相关
    ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Show hover" },
    ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto Definition" },
    ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Goto declaration" },
    ["gr"] = { "<cmd>lua vim.lsp.buf.references()<CR>", "Goto references" },
    ["gi"] = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto Implementation" },
    ["gs"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR", "show signature help" },
}, { prefix = "" })

which_key.register({
    -- 打开/关闭目录树
    e = { ":NvimTreeToggle<CR>", "File Explorer" },
    -- 保存
    w = { ":w<CR>", "Save" },
    -- 退出
    q = { ":q<CR>", "Quit" },
    -- 打开代码大纲
    o = { "<cmd>SymbolsOutline<CR>", "Toggle symbols outline" },
    -- 打开启动页面
    [";"] = { "<cmd>Alpha<CR>", "Dashboard" },
}, { prefix = "<leader>" })
