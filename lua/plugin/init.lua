local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- manage itself
    "folke/lazy.nvim",
    -- 通知插件
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        config = function()
            require("plugin.nvim-notify")
        end,
    },
    -- vim 开始界面
    {
        "goolord/alpha-nvim",
        event = "VIMEnter",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("plugin.alpha")
        end,
    },
    -- 主题
    {
        "projekt0n/github-nvim-theme",
        enabled = true,
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require("github-theme").setup({})
            -- vim.cmd("colorscheme github_dark_dimmed")
        end,
    },
    {
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight")
            vim.cmd("colorscheme tokyonight")
        end,
    },
    -- 目录树
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        event = "VeryLazy",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "antosha417/nvim-lsp-file-operations",
            "echasnovski/mini.base16",
        },
        config = function()
            require("plugin.nvim-tree")
        end,
    },
    -- which-key
    {
        "folke/which-key.nvim",
        config = function()
            require("which-key")
        end,
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
    },
    -- 底部状态栏
    {
        "nvim-lualine/lualine.nvim",
        event = "UIEnter",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "f-person/git-blame.nvim",
        },
        config = function()
            require("plugin.lualine")
        end,
    },
    -- 语法高亮
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        event = "VeryLazy",
        build = ":TSUpdate",
        config = function()
            require("plugin.nvim-treesitter")
        end,
    },
    -- 代码大纲
    {
        "simrat39/symbols-outline.nvim",
        lazy = true,
        cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
        config = function()
            require("plugin.symbols-outline")
        end
    },
    -- LSP
    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
        dependencies = {
            "neovim/nvim-lspconfig",
            "williamboman/mason-lspconfig.nvim",
            {
                "mfussenegger/nvim-dap",
                dependencies = {
                    "rcarriga/nvim-dap-ui",
                },
            },
            "b0o/schemastore.nvim",
            "folke/neodev.nvim",
        },
        config = function()
            require("plugin.mason")
        end,
    },
    -- 代码补全
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            -- "hrsh7th/cmp-path",
            -- async path
            "FelipeLema/cmp-async-path",
            "lukas-reineke/cmp-rg",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            --
            -- "L3MON4D3/LuaSnip",
            -- "saadparwaiz1/cmp_luasnip",
            "hrsh7th/vim-vsnip",
            "hrsh7th/cmp-vsnip",
            --- ui denpendences
            "onsails/lspkind-nvim",
            --- autopairs
            "windwp/nvim-autopairs",
            "rafamadriz/friendly-snippets",
        },
        event = "VeryLazy",
        config = function()
            require("plugin.cmp")
        end,
    },
    -- 代码格式化, 自动导入
    {
        "stevearc/conform.nvim",
        event = "VeryLazy",
        config = function()
            require("plugin.conform")
        end,
    },
})
