-- 参考: https://zhuanlan.zhihu.com/p/590908735
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


vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })

--
vim.fn.sign_define(
    "DapBreakpoint",
    { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
    "DapBreakpointCondition",
    { text = "ﳁ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
    "DapBreakpointRejected",
    { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
    "DapLogPoint",
    { text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
)
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })


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

-- Go 语言调试
require("dap-go").setup()
dap.adapters.go = function(callback, _)
    local stdout = vim.loop.new_pipe(false)
    local handle
    local pid_or_err
    local port = 38697
    local opts = {
        stdio = { nil, stdout },
        args = { "dap", "-l", "127.0.0.1:" .. port },
        detached = true,
    }
    
    handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
        stdout:close()
        handle:close()
        if code ~= 0 then
            print("dlv exited with code", code)
        end
    end)
    assert(handle, "Error running dlv: " .. tostring(pid_or_err))
    stdout:read_start(function(err, chunk)
        assert(not err, err)
        if chunk then
            vim.schedule(function()
                require("dap.repl").append(chunk)
            end)
        end
    end)
    
    vim.defer_fn(function()
        callback { type = "server", host = "127.0.0.1", port = port }
    end, 100)
end

-- 此处获取命令行输入参数，其他语言的配置也是可以加的啦
-- 主要是这个程序是一个简单的容器实验，模仿实现docker所以需要从命令行输入参数
local get_args = function()
    -- 获取输入命令行参数
    local cmd_args = vim.fn.input('CommandLine Args:')
    local params = {}
    -- 定义分隔符(%s在lua内表示任何空白符号)
    for param in string.gmatch(cmd_args, "[^%s]+") do
        table.insert(params, param)
    end
    return params
end;

dap.configurations.go = {
    -- 普通文件的debug
    {
        type = "go",
        name = "Debug",
        request = "launch",
        args = get_args,
        program = "${file}",
    },
    -- 测试文件的debug
    {
        type = "go",
        name = "Debug test", -- configuration for debugging test files
        request = "launch",
        args = get_args,
        mode = "test",
        program = "${file}",
    },
}
