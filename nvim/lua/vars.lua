-- [[ vars.lua ]]

-- Set language to US english so that ORG doesn't use localized dates
vim.cmd("language en_US.utf8")
vim.cmd("noremap <space><space> :")

local g = vim.g

-- Set leader/local leader keys
g.mapleader = " "
g.localleader = "\\"
