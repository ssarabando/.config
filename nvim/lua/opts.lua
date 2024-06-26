--[[ opts.lua ]]

local opt = vim.opt   
local cmd = vim.api.nvim_command

-- [[ Context ]]
opt.colorcolumn = '120'          -- str:  Show col for max line length
opt.number = true                -- bool: Show line numbers
opt.relativenumber = true        -- bool: Show relative line numbers
opt.scrolloff = 5                -- int:  Min num lines of context
opt.signcolumn = "yes"           -- str:  Show the sign column
vim.wo.wrap = true               -- bool: Don't wrap lines.

--  [[ Clipboard ]]
opt.clipboard = "unnamedplus"

-- [[ Filetypes ]]
opt.encoding = 'utf8'            -- str:  String encoding to use
opt.fileencoding = 'utf8'        -- str:  File encoding to use

-- [[ Theme ]]
opt.syntax = "ON"                -- str:  Allow syntax highlighting
opt.termguicolors = true         -- bool: If term supports ui color then enable

-- [[ Search ]]
opt.ignorecase = true            -- bool: Ignore case in search patterns
opt.smartcase = true             -- bool: Override ignorecase if search contains capitals
opt.incsearch = true             -- bool: Use incremental search
opt.hlsearch = false             -- bool: Highlight search matches
opt.inccommand = "split"         -- str:  While substituting, show split with all lines being replaced

-- [[ Whitespace ]]
opt.expandtab = true             -- bool: Use spaces instead of tabs
opt.shiftwidth = 4               -- num:  Size of an indent
opt.softtabstop = 4              -- num:  Number of spaces tabs count for in insert mode
opt.tabstop = 4                  -- num:  Number of spaces tabs count for
opt.virtualedit = "block"        -- str:  Virtual edit only in block (C-V) mode

-- [[ Splits ]]
opt.splitright = true            -- bool: Place new window to right of current one
opt.splitbelow = true            -- bool: Place new window below the current one

--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
opt.completeopt = {'menuone', 'noselect', 'noinsert'}
-- vim.cmd([[
--     let g:completion_enable_auto_popup = 1
-- ]])
opt.shortmess = opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 300) 

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error 
-- Show inlay_hints more frequently 
opt.signcolumn = "yes"
vim.cmd([[
    autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- [[ Plugins ]]

-- Vimspector options
-- vim.cmd([[
-- let g:vimspector_sidebar_width = 85
-- let g:vimspector_bottombar_height = 15
-- let g:vimspector_terminal_maxwidth = 70
-- ]])

