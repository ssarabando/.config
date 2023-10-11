--[[ keys.lua ]]

local wk = require("which-key")
-- Global keybinds, normal mode.
wk.register({
    -- Move lines
    -- https://vimtricks.com/p/vimtrick-moving-lines/
    ["<c-j>"] = { "<cmd>m .+1<cr>==", "Move current line down." },
    ["<c-k>"] = { "<cmd>m .-2<CR>==", "Move current line up." },
    ["<leader>"] = {
        d = {
            name = "diagnostics",
            l = { vim.diagnostic.setloclist, "Add to the location list" },
            s = { vim.diagnostic.open_float, "Show" },
            n = { vim.diagnostic.goto_next, "Goto next diagnostic" },
            p = { vim.diagnostic.goto_prev, "Goto previous diagnostic" },
        },
        f = {
            name = "file",
            b = { "<cmd>Telescope buffers<cr>", "Buffers" },
            f = { "<cmd>Telescope find_files<cr>", "Find files" },
            g = { "<cmd>Telescope live_grep<cr>", "Live GREP" },
            h = { "<cmd>Telescope help_tags<cr>", "Help tags" },
            r = { "<cmd>Telescope oldfiles<cr>", "Recent files" },
        },
        l = {
            name = "LSP",
            d = { "<cmd>Telescope lsp_definitions<cr>", "Goto definition" },
            r = { "<cmd>Telescope lsp_references<cr>", "List/goto references" },
        },
    },
})
-- Global keybinds, insert mode.
wk.register({
    -- Move lines
    -- https://vimtricks.com/p/vimtrick-moving-lines/
    ["<c-j>"] = { "<esc><cmd>m .+1<CR>==gi", "Move current line down." },
    ["<c-k>"] = { "<esc><cmd>m .-2<CR>==gi", "Move current line up." },
}, { mode = "i" })
-- Global keybinds, visual mode.
wk.register({
    -- Move lines
    -- https://vimtricks.com/p/vimtrick-moving-lines/
    ["<c-j>"] = { "<esc><cmd>m '>+1<CR>gv=gv", "Move current line down." },
    ["<c-k>"] = { "<esc><cmd>m '<-2<CR>gv=gv", "Move current line up." },
}, { mode = "v" })

local map = vim.api.nvim_set_keymap

-- LSP
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        wk.register({
            ["<leader>l"] = {
                i = { vim.lsp.buf.implementation, "Goto implementation", buffer = ev.buf },
            },
        })
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {
            buffer = ev.buf,
            desc = "Jumps to the declaration of the symbol under the cursor."
        })
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {
            buffer = ev.buf,
            desc = "Jumps to the definition of the symbol under the cursor."
        })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
          vim.lsp.buf.format { async = true }
        end, opts)
    end,
})

-- CTAGS VIEWER: tagbar
-- show classes
-- map('n', "<leader>sc", ":TagbarToggle<CR>", {})

-- numToStr Comment plugin default keybindings
-- [count]gcc|gc[count]{motion}: line comment
-- gc: line comment (VISUAL mode)
-- [count]gbc|gb[count]{motion}: block comment
-- gb: block comment (VISUAL mode)
