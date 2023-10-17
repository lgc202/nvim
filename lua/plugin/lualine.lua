local status, lualine = pcall(require, "lualine")
if not status then
    vim.notify("not found lualine")
    return
end

-- local git_blame = require("gitblame")
--
-- lualine.setup({
--     sections = {
--         lualine_c = {
--             { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available },
--         },
--     },
-- })
lualine.setup({
    options = {
        -- https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
        theme = "tokyonight",
        component_separators = {
            left = "|",
            right = "|",
        },
        -- https://github.com/ryanoasis/powerline-extra-symbols
        section_separators = {
            left = " ",
            right = "",
        },
        globalstatus = true,
    },
    extensions = { "nvim-tree" },
    sections = {
        lualine_c = {
            {
                "filename",
                file_status = true, -- displays file status (readonly status, modified status)
                path = 2,           -- 0 = just filename, 1 = relative path, 2 = absolute path
            },
        },
        lualine_x = {
            "filesize",
            {
                "fileformat",
                -- symbols = {
                --   unix = '', -- e712
                --   dos = '', -- e70f
                --   mac = '', -- e711
                -- },
                symbols = {
                    unix = "LF",
                    dos = "CRLF",
                    mac = "CR",
                },
            },
            "encoding",
            "filetype",
        },
    }
})