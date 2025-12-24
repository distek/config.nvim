local plugins = {}

table.insert(plugins, require("plugins.treesitter.treesitter"))
table.insert(plugins, require("plugins.treesitter.swap"))
table.insert(plugins, require("plugins.treesitter.autotag"))
table.insert(plugins, require("plugins.treesitter.commentstring"))
table.insert(plugins, require("plugins.treesitter.context"))
table.insert(plugins, require("plugins.treesitter.rainbow-delimiters"))
table.insert(plugins, require("plugins.treesitter.textobjects"))

return plugins
