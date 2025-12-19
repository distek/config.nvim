return {
    "lucobellic/edgy-group.nvim",
    dependencies = { "folke/edgy.nvim" },
    event = "VeryLazy",
    config = function()
        require("edgy-group").setup({
            groups = {
                right = { { icon = "󰊕", titles = { "Outline", "Tests" } } },
                left = {
                    { icon = "", titles = { "Files" } },
                    { icon = "", titles = { "Scopes", "Breakpoints", "Stacks", "Watches" } },
                },
                bottom = {
                    { icon = "", titles = { "Terminal", "List" } },
                    { icon = "", titles = { "Debug Console", "Debug REPL" } },
                },
            },
            -- configuration for `require('edgy-group.stl').get_statusline(pos)`
            statusline = {
                -- suffix and prefix separators between icons
                separators = { " ", " " },
                clickable = true,                  -- open group on click
                colored = false,                   -- enable highlight support
                colors = {                         -- highlight colors
                    active = "Normal",             -- highlight color for open group
                    inactive = "Normal",           -- highlight color for closed group
                    pick_active = "PmenuSel",      -- highlight color for pick key for open group
                    pick_inactive = "PmenuSel",    -- highlight color for pick key for closed group
                    separator_active = "Normal",   -- highlight color for separator for open group
                    separator_inactive = "Normal", -- highlight color for separator for closed group
                },
                -- pick key position: left, right, left_separator, right_separator, icon
                -- left: before left separator
                -- right: after right separator
                -- left_separator, right_separator and icon: replace the corresponding element
                pick_key_pose = "left",
                pick_function = nil, -- optional function to override default behavior
            },
            toggle = true,           -- toggle group when at least one window is already open
        })
    end,
}
