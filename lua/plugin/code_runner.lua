local status, code_runner = pcall(require, "code_runner")
if not status then
    vim.notify("not found code_runner")
    return
end

code_runner.setup({
    config = true,
    filetype = {
        go = "go run .",
        python = "python3 -u",
    },
})
