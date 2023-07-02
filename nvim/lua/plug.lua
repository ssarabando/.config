-- Reload configurations if we modify plugins.lua
-- Hint
--     <afile> - replaced with the filename of the buffer being manipulated
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost lua/plug.lua source <afile> | PackerSync
    augroup end
]])

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'http://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
    -- [[ PLUGIN ]]

    -- Packer can manage itself
    use "wbthomason/packer.nvim"

    -- [[ VISUALS ]]
    use {
        "Mofiqul/dracula.nvim",                         -- Dracula theme
        config = function()
            vim.api.nvim_command('colorscheme dracula')
        end,
    }

    use {
        "nvim-lualine/lualine.nvim",                    -- Status line
        requires = {
            "nvim-tree/nvim-web-devicons",              -- Icons for the tree
            opt = true
        },
        config = function()
            require("lualine").setup()
        end,
    }
    
    use {
        "folke/noice.nvim",                             -- Replace UI for command line, messages, etc.
        requires = {
            "MunifTanjim/nui.nvim",                     -- UI component library
            "rcarriga/nvim-notify",                     -- Notification manager
        },
        config = function()
            require("noice").setup()
        end,
    }

    use {
        "folke/which-key.nvim",                         -- Popups for commands
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 400
            require("which-key").setup()
        end
    }

    use {
        "nvim-tree/nvim-tree.lua",                      -- File explorer
        requires = {
            "nvim-tree/nvim-web-devicons",              -- Icons for the tree
            opt = true
        },
        config = function()
            require('nvim-tree').setup()
        end
    }

    use "danilamihailov/beacon.nvim"                    -- Beacon plugin (see your cursor jump)

    -- [[ UTILITIES ]]

    use {
        "nvim-telescope/telescope-fzf-native.nvim",     -- fzf C port
        config = function()
            require("telescope").setup()
        end,
        run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
    }
    use {
        "nvim-telescope/telescope.nvim",                -- Fuzzy finder
        requires = { { "nvim-lua/plenary.nvim" } }
    }

    use "voldikss/vim-floaterm"                         -- Floating terminal

    -- [[ ORG ]]

    use {
        "nvim-orgmode/orgmode",                         -- ORG mode
        config = function()
            require("orgmode").setup_ts_grammar()
            require("orgmode").setup({
                org_agenda_files = {
                    "~/Dropbox/sergio/org/*",
                },
                org_default_notes_file = "~/Dropbox/sergio/org/refile.org",
            })
        end,
    }

    -- [[ DEV ]]

    use "tpope/vim-fugitive"                            -- Git integration
    use "lewis6991/gitsigns.nvim"                       -- Git decorations
    use "junegunn/gv.vim"                               -- Git commit history

    use {
        "williamboman/mason.nvim",                      -- Package manager for LSP, DAP, linters, etc.
        config = function()
            require("mason").setup({
                ensure_installed = { "gopls" }          -- GO LSP
            })
        end,
        run = ":MasonUpdate",
    }

    use {
        "neovim/nvim-lspconfig",                        -- Configs for the LSP
        config = function()
            local lspconfig = require "lspconfig"
            local util = require "lspconfig/util"
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
            -- GO
            lspconfig.gopls.setup({
                cmd = { "gopls", "serve" },
                filetypes = { "go", "gomod" },
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({
                            group = augroup,
                            buffer = bufnr,
                        })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({
                                    bufnr = bufnr
                                })
                            end,
                        })
                    end
                    -- Enable completion triggered by <c-x><c-o>
                    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
                end,
                root_dir = util.root_pattern("go.work", "go.mod", ".git"),
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                        },
                        completeUnimported = true,
                        staticcheck = true,
                        usePlaceholders = true,
                    },
                },
            })
        end,
    }

    use {
        "williamboman/mason-lspconfig.nvim",            -- Mason/LspConfig bridge
        requires = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("mason-lspconfig").setup()
        end,
    }

    use {
        "jose-elias-alvarez/null-ls.nvim",              -- Use NeoVim as a language server
        requires = { { "nvim-lua/plenary.nvim" } },     -- Library of utility functions
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.gofmt,
                    null_ls.builtins.formatting.goimports,
                },
           })
        end
    }

    use {
        "simrat39/rust-tools.nvim",                     -- Rust tools; also sets LSP for it
        config = function()
            local rt = require("rust-tools")
            rt.setup({
                server = {
                    on_attach = function(_, bufnr)
                        -- Hover actions
                        vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                        -- Code action groups
                        vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
                    end,
                },
            })
        end,
    }

    use {
        "puremourning/vimspector",                      -- Multi-language graphical debugger
        ft = "rust",
        config = function()
            map("n", "<F5>", ":call vimspector#Launch()<CR>", {
                desc = "VIMspector: start/continue debugging.",
            })
            map("n", "<S-F5>", ":call vimspector#Reset()<CR>", {
                desc = "VIMspector: stop debugging.",
            })
            map("n", "<F9>", ":call vimspector#ToggleBreakpoint()<CR>", {
                desc = "VIMspector: toggle breakpoint.",
            })
            map("n", "<S-F9>", ":call vimspector#AddWatch()<CR>", {
                desc = "VIMspector: add watch.",
            })
            map("n", "<F10>", ":call vimspector#StepOver()<CR>", {
                desc = "VIMspector: step over.",
            })
            map("n", "<F11>", ":call vimspector#StepInto()<CR>", {
                desc = "VIMspector: step into.",
            })
            map("n", "<S-F11>", ":call vimspector#StepOut()<CR>", {
                desc = "VIMspector: step out.",
            })
        end
    }

    use {
        "hrsh7th/nvim-cmp",                             -- Completion framework
        requires = {
            "hrsh7th/cmp-nvim-lsp",                     -- Source for NeoVim's builtin LSP client
            "hrsh7th/cmp-nvim-lua",                     -- Source for NeoVim's Lua API
            "hrsh7th/cmp-nvim-lsp-signature-help",      -- Source for displaying function signatures
            "hrsh7th/cmp-vsnip",                        -- Source for vim-vsnip
            "hrsh7th/cmp-path",                         -- Source for paths
            "hrsh7th/cmp-buffer",                       -- Source for buffer words
            "hrsh7th/cmp-calc",                         -- Source for math calculations
            "hrsh7th/vim-vsnip",                        -- Snippet plugin that supports LSP/VSCode's snippet format
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
              -- Enable LSP snippets
              snippet = {
                expand = function(args)
                    vim.fn["vsnip#anonymous"](args.body)
                end,
              },
              mapping = {
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                -- Add tab support
                ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                ["<Tab>"] = cmp.mapping.select_next_item(),
                ["<C-S-f>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.close(),
                ["<CR>"] = cmp.mapping.confirm({
                  behavior = cmp.ConfirmBehavior.Insert,
                  select = true,
                })
              },
              -- Installed sources:
              sources = {
                { name = "path" },                         -- file paths
                { name = "nvim_lsp", keyword_length = 3 }, -- from language server
                { name = "nvim_lsp_signature_help" },      -- display function signatures with current parameter emphasized
                { name = "nvim_lua", keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
                { name = "buffer", keyword_length = 2 },   -- source current buffer
                { name = "vsnip", keyword_length = 2 },    -- nvim-cmp source for vim-vsnip 
                { name = "calc" },                         -- source for math calculation
              },
              window = {
                  completion = cmp.config.window.bordered(),
                  documentation = cmp.config.window.bordered(),
              },
              formatting = {
                  fields = { "menu", "abbr", "kind" },
                  format = function(entry, item)
                      local menu_icon ={
                          nvim_lsp = "λ",
                          vsnip = "⋗",
                          buffer = "Ω",
                          path = "🖫",
                      }
                      item.menu = menu_icon[entry.source.name]
                      return item
                  end,
              },
            })
        end,
    } 

    use {
        "mfussenegger/nvim-dap",                        -- DAP implementation
        config = function()
            local map = vim.api.nvim_set_keymap
            map("n", "<F5>", "<cmd>lua require('dap').continue()<CR>", {
                desc = "DAP: start/continue debugging."
            })
            map("n", "<S-F5>", ":DapTerminate<CR>", {
                desc = "DAP: stop debugging."
            })
            map("n", "<F9>", ":DapToggleBreakpoint<CR>", {
                desc = "DAP: toggle breakpoint."
            })
            map("n", "<F10>", ":DapStepOver<CR>", {
                desc = "DAP: step over."
            })
            map("n", "<F11>", ":DapStepInto<CR>", {
                desc = "DAP: step into."
            })
            map("n", "<S-F11>", ":DapStepOut<CR>", {
                desc = "DAP: step out."
            })
            map("n", "<leader>dos", "<cmd>lua require('dap.ui.widgets').sidebar(require('dap.ui.widgets').scopes).open()<CR>", {
                desc = "DAP: show scopes in sidebar."
            })
        end,
    }

    use { 
        "nvim-treesitter/nvim-treesitter",              -- Treesitter configurations and abstraction layer for Neovim. 
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "go", "lua", "org", "rust", "toml" },
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { "org" },
                },
                ident = { enable = true },
                rainbow = {
                    enable = true,
                    extended_mode = true,
                    max_file_lines = nil,
                },
            })
        end,
    }

    use { 
        "theHamsta/nvim-dap-virtual-text",              -- See variable values as virtual text when debugging.
        requires = {
            "mfussenegger/nvim-dap",
            "nvim-treesitter/nvim-treesitter"
        },
        config = function()
            require("nvim-dap-virtual-text").setup()
        end
    }

    use {
        "leoluz/nvim-dap-go",                           -- DAP for GO
        ft = "go",
        config = function()
            require("dap-go").setup()
            local map = vim.api.nvim_set_keymap
            map("n", "<leader>dgt", "<cmd>lua require('dap-go').debug_test()<CR>", {
                desc = "DAP-GO: debug test."
            })
            map("n", "<leader>dgl", "<cmd>lua require('dap-go').debug_last_test()<CR>", {
                desc = "DAP-GO: debug last test."
            })
        end
    }

    use "preservim/tagbar"                              -- Class/file outliner

    use {
        "folke/trouble.nvim",                           -- Pretty list for showing diagnostics, etc.
        requires = {
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require("trouble").setup()
        end,
    }

    use {
        "folke/todo-comments.nvim",                     -- Highlight TODO comments, etc.
        requires = { { "nvim-lua/plenary.nvim" } },
        config = function()
            require("todo-comments").setup()
        end,
    }

    use {
        "lukas-reineke/indent-blankline.nvim",          -- Show indent guides
        config = function()
            require("indent_blankline").setup({
                show_current_context = true,
                show_current_context_start = true,
            })
        end,
    }

    use {
        "windwp/nvim-autopairs",                        -- Autoclose brackets, etc.
        config = function()
            require("nvim-autopairs").setup()
        end,
    }

    use "tpope/vim-surround"                            -- Surround stuff with brackets, quotes, etc.
    use "RRethy/vim-illuminate"                         -- Highlights other uses of the word under the cursor.

    use {
        "numToStr/Comment.nvim",                        -- Comments plugin
        config = function()
            require("Comment").setup()
        end,
    }

    use {
        "m-demare/hlargs.nvim",                         -- Highlight arguments
        config = function()
            require("hlargs").setup()
        end,
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
