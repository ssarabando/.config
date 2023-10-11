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
            d = { "<cmd>Telescope lsp_definitions<cr>", "Goto word definition" },
            r = { "<cmd>Telescope lsp_references<cr>", "List/goto word references" },
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
        -- Normal mode keybinds.
        wk.register({
            ["<leader>l"] = {
                ["."] = { vim.lsp.buf.code_action, "Code actions", buffer = ev.buf },
                d = { vim.lsp.buf.definition, "Goto symbol definition", buffer = ev.buf },
                D = { vim.lsp.buf.declaration, "Goto declaration", buffer = ev.buf },
                f = { function() vim.lsp.buf.format { async = true } end, "Format buffer", buffer = ev.buf },
                h = { vim.lsp.buf.hover, "Show information about symbol", buffer = ev.buf },
                i = { vim.lsp.buf.implementation, "Goto implementation", buffer = ev.buf },
                r = { vim.lsp.buf.references, "List/goto symbol references" , buffer = ev.buf },
                R = { vim.lsp.buf.rename, "Rename" , buffer = ev.buf },
                s = { vim.lsp.buf.signature_help, "Show signature help", buffer = ev.buf },
                t = { vim.lsp.buf.type_definition, "Goto type definition", buffer = ev.buf },
            },
        })
        -- Visual mode keybinds.
        wk.register({
            ["<leader>l"] = {
                ["."] = { vim.lsp.buf.code_action, "Code actions", buffer = ev.buf },
            },
        }, { mode = "v" })
        -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    end,
})
