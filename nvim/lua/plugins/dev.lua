return {
    -- Git plugin
    -- https://github.com/tpope/vim-fugitive
    "tpope/vim-fugitive",
    -- https://github.com/tpope/vim-surround
    "tpope/vim-surround",
    -- https://github.com/tpope/vim-dadbod
    -- "tpope/vim-dadbod",
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
	    { "tpope/vim-dispatch" },
            { "tpope/vim-dadbod", lazy = true },
            { "kristijanhusak/vim-dadbod-completion", ft = { "sql" }, lazy = true },
        },
        cmd = {
            "DBUI",
            "DBUIToggle",
            "DBUIAddConnection",
            "DBUIFindBuffer",
        },
        init = function()
            vim.g.db_ui_use_nerd_fonts = 1
        end,
    },
    -- Git decorations
    -- https://github.com/lewis6991/gitsigns.nvim
    {
        "lewis6991/gitsigns.nvim",
        config = true,
        lazy = false,
    },
    -- Git commit history
    -- https://github.com/junegunn/gv.vim
    {
        "junegunn/gv.vim",
        dependencies = {
            "tpope/vim-fugitive",
        },
    },
    -- Snippets
    { "hrsh7th/cmp-vsnip" },
    { "hrsh7th/vim-vsnip" },
    -- Completion
    {
        -- Autocompletion plugin
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<cr>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                    ["<c-space>"] = cmp.mapping.complete(),
                    ["<tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<s-tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    -- TODO: this throws an error when writing code
                    -- { name = "nvim_lsp" },
                    { name = "vsnip" },
                }),
                window = {
                    completion = cmp.config.window.bordered,
                    documentation = cmp.config.window.bordered,
                },
            })
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")
            local servers = { "zls" }
            for _, lsp in ipairs(servers) do
                lspconfig[lsp].setup {
                    capabilities = capabilities
                }
            end
        end,
        dependencies = {
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
        },
    },
    {
        -- LSP source for nvim-cmp
        "hrsh7th/cmp-nvim-lsp",
        dependencies = {
            "hrsh7th/nvim-cmp",
            "neovim/nvim-lspconfig",
        },
    },
    -- LSP configuration
    {
        "neovim/nvim-lspconfig",
        config = function(_, opts)
            require("lspconfig").zls.setup {}
        end,
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        dependencies = {
            "ziglang/zig.vim",
        },
    },
    -- Pretty list for showing diagnostics, etc.
    {
        "folke/trouble.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    },
    -- Commenting
    -- https://github.com/numToStr/Comment.nvim
    {
        "numToStr/Comment.nvim",
        config = true,
        lazy = false,
    },
    -- Autopair plugin
    -- https://github.com/windwp/nvim-autopairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },
}
