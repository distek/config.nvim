local plugins = {}

table.insert(plugins, require("plugins.filetype.c"))
table.insert(plugins, require("plugins.filetype.csv"))
table.insert(plugins, require("plugins.filetype.md"))
table.insert(plugins, require("plugins.filetype.openscad"))
table.insert(plugins, require("plugins.filetype.rust"))

return plugins
