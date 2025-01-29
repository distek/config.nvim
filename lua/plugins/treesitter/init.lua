local plugins = {}

table.insert(plugins, require("plugins.treesitter.autotag"))
table.insert(plugins, require("plugins.treesitter.commentstring"))
table.insert(plugins, require("plugins.treesitter.context"))
table.insert(plugins, require("plugins.treesitter.playground"))
table.insert(plugins, require("plugins.treesitter.rainbow-delimiters"))
table.insert(plugins, require("plugins.treesitter.textobjects"))
table.insert(plugins, require("plugins.treesitter.treesitter"))

return plugins
