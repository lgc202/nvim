local status, dap = pcall(require, "dap")
if not status then
    vim.notify("not found dap")
    return
end

local status, dapui = pcall(require, "dapui")
if not status then
    vim.notify("not found dapui")
    return
end

local status, vt = pcall(require, "nvim-dap-virtual-text")
if not status then
    vim.notify("not found nvim-dap-virtual-text")
    return
end

require("plugin.dap.ui")

vt.setup({
    commented = true,
})

dapui.setup({
    element_mappings = {
        scopes = {
            open = "<CR>",
            edit = "e",
            expand = "o",
            repl = "r",
        },
    },
    layouts = {
        {
            elements = {
                -- Elements can be strings or table with id and size keys.
                { id = "scopes", size = 0.4 },
                "stacks",
                "watches",
                "breakpoints",
                "console",
            },
            size = 0.35, -- 40 columns
            position = "left",
        },
        {
            elements = {
                "repl",
            },
            size = 0.25, -- 25% of total lines
            position = "bottom",
        },
    },
    floating = {
        max_height = nil,   -- These can be integers or a float between 0 and 1.
        max_width = nil,    -- Floats will be treated as percentage of your screen.
        border = "rounded", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end


-- 参考: https://zhuanlan.zhihu.com/p/590908735
-- 暂时使用默认的配置, 所以先注释掉, 并且调用require("dap-go").setup()
require("dap-go").setup()
-- require("plugin.dap.config.golang")
