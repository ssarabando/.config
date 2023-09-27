--[[ keys.lua ]]

local map = vim.api.nvim_set_keymap

-- TERMINAL
-- Terminal: new
-- map('n', "<leader>tn", ":FloatermNew --name=Terminal --height=0.8 --width=0.7 --autoclose=2 pwsh <CR> ", {})
-- Terminal: attach
-- map('n', "<leader>ta", ":FloatermToggle Terminal<CR>", {})
-- Terminal: dettach
-- map('t', "<Esc>", "<C-\\><C-n>:q<CR>", {})

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
