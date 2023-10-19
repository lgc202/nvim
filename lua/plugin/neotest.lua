local status, neotest = pcall(require, "neotest")
if not status then
    vim.notify("not found neotest")
    return
end

-- get neotest namespace (api call creates or returns namespace)
local neotest_ns = vim.api.nvim_create_namespace("neotest")
vim.diagnostic.config({
    virtual_text = {
        format = function(diagnostic)
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
        end,
    },
}, neotest_ns)

neotest.setup({
    adapters = {
        require("neotest-go")({
            experimental = {
                test_table = true,
            },
            args = { "-count=1", "-timeout=60s" }
        }),
        -- TODO 其它语言
    },

    summary = {
        animated = true,
        enabled = true,
        expand_errors = true,
        follow = true,
        mappings = {
            expand = { "o", "<2-LeftMouse>" },
            jumpto = "<CR>",
            output = "O",
            short = "s",
        },
    },

    icons = {
        passed = "",
        failed = "",
        running = "",
        running_animated = { "▫", "▪" },
        skipped = "-",
        unknown = "",
    },
    diagnostic = {
        enabled = true,
    },
    status = {
        signs = false,
        virtual_text = true,
    },
})
