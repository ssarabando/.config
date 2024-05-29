-- [[ ORG ]]

return {
    -- ORG mode
    {
        "nvim-orgmode/orgmode",
        event = "VeryLazy",
        config = function()
            -- Setup orgmode
            require("orgmode").setup({
                org_agenda_files = {
                    "~/Documents/org/*",
                },
                org_default_notes_file = "~/Documents/org/refile.org",
                org_todo_keywords = {
                    'TODO(t)',
                    '|',
                    'DONE',
                    'CANCELLED'
                }
            })
        end,
    },
}
