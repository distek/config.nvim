local plugins = {}

table.insert(plugins, require("plugins.ui.theme"))

table.insert(plugins, require("plugins.ui.bufferline"))
table.insert(plugins, require("plugins.ui.bufresize"))
table.insert(plugins, require("plugins.ui.edgy"))
table.insert(plugins, require("plugins.ui.gitsigns"))
table.insert(plugins, require("plugins.ui.hlchunk"))
-- table.insert(plugins, require("plugins.ui.hlslens"))
table.insert(plugins, require("plugins.ui.lualine"))
-- table.insert(plugins, require("plugins.ui.neo-tree"))
table.insert(plugins, require("plugins.ui.panel"))
table.insert(plugins, require("plugins.ui.telescope"))
table.insert(plugins, require("plugins.ui.tint"))
table.insert(plugins, require("plugins.ui.trouble"))
table.insert(plugins, require("plugins.ui.which-key"))
table.insert(plugins, require("plugins.ui.winshift"))
table.insert(plugins, require("plugins.ui.zen-mode"))

return plugins
