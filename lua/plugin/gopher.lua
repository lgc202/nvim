local status, gopher = pcall(require, "gopher")
if not status then
    vim.notify("not found gopher")
    return
end

gopher.setup({
    commands = {
        go = "go",
        -- -transform camelcase表示采用驼峰式的 tags
        gomodifytags = "gomodifytags",
        -- 也可以自定义工具的位置 /root/.gvm/pkgsets/go1.20.6/global/bin/
        gotests = "gotests",
        impl = "impl",
        iferr = "iferr",
    },
})
