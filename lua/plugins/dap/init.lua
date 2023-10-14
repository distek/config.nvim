local plugins = {}

table.insert(plugins, require("plugins.dap.dap"))
table.insert(plugins, require("plugins.dap.dap-go"))
table.insert(plugins, require("plugins.dap.dap-python"))
table.insert(plugins, require("plugins.dap.dap-ui"))
table.insert(plugins, require("plugins.dap.dap-virtual-text"))

return plugins
