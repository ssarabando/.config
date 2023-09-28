--[[ keys.lua ]]

local map = vim.api.nvim_set_keymap

-- FUZZY FINDER
map('n', "<leader>ff", ":Telescope find_files<CR>", {})
map('n', "<leader>fg", ":Telescope live_grep<CR>", {})
map('n', "<leader>fb", ":Telescope buffers<CR>", {})
map('n', "<leader>fh", ":Telescope help_tags<CR>", {})
map('n', "<leader>fd", ":Telescope lsp_definitions<CR>", {})
map('n', "<leader>fr", ":Telescope lsp_references<CR>", {})

-- Move lines
-- https://vimtricks.com/p/vimtrick-moving-lines/
map("n", "<c-j>", ":m .+1<CR>==", {})
map("n", "<c-k>", ":m .-2<CR>==", {})
map("i", "<c-j>", "<Esc>:m .+1<CR>==gi", {})
map("i", "<c-k>", "<Esc>:m .-2<CR>==gi", {})
map("v", "<c-j>", ":m '>+1<CR>gv=gv", {})
map("v", "<c-k>", ":m '<-2<CR>gv=gv", {})
-- CTAGS VIEWER: tagbar
-- show classes
-- map('n', "<leader>sc", ":TagbarToggle<CR>", {})

-- numToStr Comment plugin default keybindings
-- [count]gcc|gc[count]{motion}: line comment
-- gc: line comment (VISUAL mode)
-- [count]gbc|gb[count]{motion}: block comment
-- gb: block comment (VISUAL mode)
