return {
    -- Vim plugin for Git
    "tpope/vim-fugitive",
    -- Git decorations
    "lewis6991/gitsigns.nvim",
    -- Git commit history
    "junegunn/gv.vim",
    -- Pretty list for showing diagnostics, etc.
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
    {
        "folke/trouble.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    },
}
