local status, conform = pcall(require, "conform")
if not status then
    vim.notify("not found conform")
    return
end

conform.setup({
    formatters_by_ft = {
        go = {
            formatters = { "gofumpt", "goimports" },
            run_all_formatters = true,
        },
        html = { "prettierd" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        bash = { "shfmt" },
        lua = { "stylua" },
        -- Conform will use the first available formatter in the list

        -- Formatters can also be specified with additional options
        python = {
            formatters = { "isort", "black" },
            -- Run formatters one after another instead of stopping at the first success
            run_all_formatters = true,
        },
    },
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
    },
})
