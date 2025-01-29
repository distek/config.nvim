local plugins = {}

table.insert(plugins, require("plugins.misc.commentary"))
table.insert(plugins, require("plugins.misc.fnote"))
table.insert(plugins, require("plugins.misc.fugitive"))
table.insert(plugins, require("plugins.misc.gitworktree"))
table.insert(plugins, require("plugins.misc.mini-misc"))
table.insert(plugins, require("plugins.misc.neotest"))
table.insert(plugins, require("plugins.misc.obsidian"))
table.insert(plugins, require("plugins.misc.refactoring"))
table.insert(plugins, require("plugins.misc.undotree"))

return plugins
