local status, notify = pcall(require, "notify")
if not status then
    vim.notify("not found nvim-notify")
    return
end

notify.setup({
    stages = "fade",
    timeout = 3000,
    render = "minimal",
})
-- 设为默认notify工具
vim.notify = notify
