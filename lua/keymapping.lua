local which_key = require("which-key")
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
        -- 快速移动
        s = { ":HopChar1<cr>", "Quick move to char" },
        w = { ":HopWord<cr>", "Quick move to word" },
        j = { ":HopLine<cr>", "Quick move to line" },
        k = { ":HopLine<cr>", "Quick move to line" },
    },
    -- 增强f键的功能
    ["f"] = {
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
        "Find Next",
    },
    ["F"] = {
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
        "Find Previous",
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
    -- 顶部标签相关
    b = {
        name = "+Buffer",
        j = { "<cmd>BufferLinePick<cr>", "Jump" },
        f = { "<cmd>Telescope buffers<cr>", "Find" },
        b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
        n = { "<cmd>BufferLineCycleNext<cr>", "Next" },
        c = { "<cmd>Bdelete<cr>", "Close Current" },
        o = { "<cmd>BufferLineCloseRight<CR><cmd>BufferLineCloseLeft<CR>", "Close others" },
        h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
        l = {
            "<cmd>BufferLineCloseRight<cr>",
            "Close all to the right",
        },
    },
    -- 模糊查找相关
    f = {
        name = "+Find",
        f = { "<cmd>Telescope find_files<CR>", "Find files" },
        g = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Current search" },
        G = { "<cmd>Telescope live_grep<CR>", "Global search" },
        d = { "<cmd>Telescope diagnostics bufnr=0<CR>", "Buffer diagnostics" },
        D = { "<cmd>Telescope diagnostics<CR>", "Workspace diagnostics" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = {
            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            "Workspace Symbols",
        },
        p = { "<cmd>Telescope projects<CR>", "Recent project" },
        r = { "<cmd>Telescope oldfiles<CR>", "Recent files" },
    },
    -- LSP 相关
    l = {
        name = "+LSP",
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        i = { "<cmd>LspInfo<cr>", "Info" },
        I = { "<cmd>Mason<cr>", "Mason Info" },
        j = {
            vim.diagnostic.goto_next,
            "Next Diagnostic",
        },
        k = {
            vim.diagnostic.goto_prev,
            "Prev Diagnostic",
        },
        q = { vim.diagnostic.setloclist, "Quickfix" },
        r = { vim.lsp.buf.rename, "Rename" },
        f = { "<cmd>lua require 'conform'.format({async = false,lsp_fallback = true})<cr>", "Format" },
        -- e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
    },
    -- Git 相关
    g = {
        name = "+Git",
        j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
        k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
        l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
        p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
        r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
        R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
        s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
        u = {
            "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
            "Undo Stage Hunk",
        },
        o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        C = {
            "<cmd>Telescope git_bcommits<cr>",
            "Checkout commit(for current file)",
        },
        d = {
            "<cmd>Gitsigns diffthis HEAD<cr>",
            "Git Diff",
        },
    },
    -- Terminal 相关
    t = {
        name = "+Terminal",
        t = { ":FloatermToggle<CR>", "Toggle Terminal" },
        n = { ":FloatermNew<CR>", "New Terminal" },
        l = { ":FloatermNew lazygit <CR>", "Open lazygit" }
    },

    -- 测试相关
    n = {
        name = "+Test",
        r = { "<cmd>lua require 'neotest'.run.run()<cr>", "Function" },
        -- TODO
        -- d = { "<cmd>lua require 'neotest'.run.run({ strategy = 'dap' })<cr>", "Debug" },
        f = { "<cmd>lua require 'neotest'.run.run(vim.fn.expand('%'))<cr>", "File" },
        s = { "<cmd>lua require 'neotest'.run.stop()<cr>", "Stop" },
        o = { "<cmd>lua require 'neotest'.output.open({enter = true})<cr>", "Output" },
        t = { "<cmd>lua require 'neotest'.summary.toggle()<cr>", "Toggle summary" },
    },

    -- 调试相关
    d = {
        name = "+Debug",
        -- 如果要打条件断点, 可以用 lua require'dap'.toggle_breakpoint("i==5")
        t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
        b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
        c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
        C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
        d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
        g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
        i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
        o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
        u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
        p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
        r = { "<cmd>lua require'dap'.clear_breakpoints()<cr>", "Removes all breakpoints" },
        q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
        s = { "<cmd>lua require('dap-go').debug_test()<cr>", "Debug single test" }
    },
    -- golang 增强
    c = {
        name = "+Code",
        -- -transform camelcase 表示用驼峰式, 参考 https://github.com/fatih/gomodifytags
        j = { "<cmd> GoTagAdd json -transform camelcase <CR>", "Add json struct tags" },
        J = { "<cmd> GoTagRm  json <CR>", "Remove json struct tags" },
        y = { "<cmd> GoTagAdd yaml -transform camelcase <CR>", "Add yaml struct tags" },
        Y = { "<cmd> GoTagRm  yaml <CR>", "Remove yaml struct tags" },
        r = { ":RunCode<CR>", "Run code" },
        c = { ":RunClose<CR>", "Close runner" }
    },
}, { prefix = "<leader>" })

which_key.register({
    ["\\"] = {
        name = "+Terminal",
        t = { "<C-\\><C-n>:FloatermToggle<CR>", "Toggle Terminal" },
        n = { "<C-\\><C-n>:FloatermNew<CR>", "New Terminal" },
        j = { "<C-\\><C-n>:FloatermNext<CR>", "Next Terminal" },
        k = { "<C-\\><C-n>:FloatermPrev<CR>", "Previous Terminal" },
        d = { "<C-\\><C-n>:FloatermKill<CR>", "Delete Terminal" }
    }
}, { mode = "t" })
