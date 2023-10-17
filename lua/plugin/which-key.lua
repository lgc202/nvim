local status, which_key = pcall(require, "which-key")
if not status then
    vim.notify("not found which-key")
    return
end

which_key.setup()
