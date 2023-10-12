return {
    -- Git plugin
    -- https://github.com/tpope/vim-fugitive
    "tpope/vim-fugitive",
    -- https://github.com/tpope/vim-surround
    "tpope/vim-surround",
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
            require("lspconfig").zls.setup {
                -- on_attach = require("completion").on_attach
                -- on_attach = function(_, bufnr)
                --     vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
                --     require("completion").on_attach()
                -- end
            }
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
