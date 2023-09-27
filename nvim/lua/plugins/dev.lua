return {
    -- Vim plugin for Git
    -- https://github.com/tpope/vim-fugitive
    "tpope/vim-fugitive",
    -- https://github.com/tpope/vim-surround
    "tpope/vim-surround",
    -- Git decorations
    -- https://github.com/lewis6991/gitsigns.nvim
    "lewis6991/gitsigns.nvim",
    -- Git commit history
    "junegunn/gv.vim",
    -- LSP configuration
    {
        "neovim/nvim-lspconfig",
        config = function()
            require'lspconfig'.zls.setup{}
        end,
        dependencies = {
            "ziglang/zig.vim",
            -- "nvim-lua/completion-nvim",
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
}
