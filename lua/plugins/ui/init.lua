local plugins = {}

table.insert(plugins, require("plugins.ui.theme"))

table.insert(plugins, require("plugins.ui.bufresize"))
table.insert(plugins, require("plugins.ui.edgy"))
table.insert(plugins, require("plugins.ui.edgy-groups"))
table.insert(plugins, require("plugins.ui.gitsigns"))
table.insert(plugins, require("plugins.ui.neo-tree"))
table.insert(plugins, require("plugins.ui.statuscol"))
table.insert(plugins, require("plugins.ui.statusline"))
table.insert(plugins, require("plugins.ui.tabline"))
table.insert(plugins, require("plugins.ui.telescope"))
table.insert(plugins, require("plugins.ui.trouble"))
table.insert(plugins, require("plugins.ui.which-key"))
table.insert(plugins, require("plugins.ui.window-picker"))

return plugins
