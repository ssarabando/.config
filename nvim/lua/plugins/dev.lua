return {
    -- Vim plugin for Git
    "tpope/vim-fugitive",
    -- Git decorations
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
            "nvim-lua/completion-nvim",
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
