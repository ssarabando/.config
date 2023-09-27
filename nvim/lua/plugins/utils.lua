return {
    -- Treesitter
    -- https://github.com/nvim-treesitter/nvim-treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })()
        end,
    },
    -- Telescope (fuzzy finder over lists)
    -- https://github.com/nvim-telescope/telescope.nvim
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    -- FZF (fuzzy finder)
    -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
        config = function()
            require("telescope").load_extension("fzf")
        end,
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
    },
}
