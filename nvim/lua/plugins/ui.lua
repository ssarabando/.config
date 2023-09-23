return {
    -- The colorscheme should be available when starting Neovim
    {
        "Mofiqul/dracula.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme dracula]])
        end,
    },
    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        config = true,
        dependencies = {
            -- Icons for plugins
            "nvim-tree/nvim-web-devicons",
        },
    },
    -- See your cursor jump
    "danilamihailov/beacon.nvim",
    -- Replace UI for command line, messages, etc.
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = true, -- use a classic bottom cmdline for search
                command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false, -- add a border to hover docs and signature help
            },
        },
        dependencies = {
            -- UI Component Library for Neovim
            {
                "MunifTanjim/nui.nvim",
                lazy = true,
            },
            -- Notification manager
            {
                "rcarriga/nvim-notify",
                lazy = true,
            },
        },
    },
    -- Popups for commands
    {
        "folke/which-key.nvim",
        config = true,
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 400
        end,
    },
    -- File explorer
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup {}
        end,
    },
}
