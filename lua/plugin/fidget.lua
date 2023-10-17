local status, fidget = pcall(require, "fidget")
if not status then
    vim.notify("not found fidget")
    return
end

fidget.setup({
    text = {
        spinner = "dots_pulse", -- animation shown when tasks are ongoing
        done = "✔", -- character shown when all tasks are complete
        commenced = "Started", -- message shown when task starts
        completed = "Completed", -- message shown when task completes
    },
    sources = { -- Sources to configure
        ["null-ls"] = {
            ignore = true,
        },
    },
})
