-- [[ vars.lua ]]

-- Set language to US english so that ORG doesn't use localized dates
vim.cmd("language en_US.utf8")

local g = vim.g

-- Disable netrw so it doesn't interfere with nvim-tree
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Set leader/local leader keys
g.mapleader = ","
g.localleader = "\\"
