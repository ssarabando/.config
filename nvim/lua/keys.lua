--[[ keys.lua ]]

local map = vim.api.nvim_set_keymap

-- FUZZY FINDER
map('n', "<leader>ff", ":Telescope find_files<CR>", {})
map('n', "<leader>fg", ":Telescope live_grep<CR>", {})
map('n', "<leader>fb", ":Telescope buffers<CR>", {})
map('n', "<leader>fh", ":Telescope help_tags<CR>", {})
map('n', "<leader>fd", ":Telescope lsp_definitions<CR>", {})
map('n', "<leader>fr", ":Telescope lsp_references<CR>", {})

-- FILE EXPLORER: nvim-tree
-- synch tree to file (and opens tree if hidden)
map('n', "<leader>st", ":NvimTreeFindFile<CR>", {})
-- close tree
map('n', "<leader>ct", ":NvimTreeClose<CR>", {})

-- CTAGS VIEWER: tagbar
-- show classes
-- map('n', "<leader>sc", ":TagbarToggle<CR>", {})

-- numToStr Comment plugin default keybindings
-- [count]gcc|gc[count]{motion}: line comment
-- gc: line comment (VISUAL mode)
-- [count]gbc|gb[count]{motion}: block comment
-- gb: block comment (VISUAL mode)
