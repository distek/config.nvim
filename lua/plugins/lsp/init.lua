local plugins = {}

table.insert(plugins, require("plugins.lsp.autopairs"))
table.insert(plugins, require("plugins.lsp.cmp"))
table.insert(plugins, require("plugins.lsp.lspconfig"))
table.insert(plugins, require("plugins.lsp.lspkind"))
table.insert(plugins, require("plugins.lsp.lsp-signature"))
table.insert(plugins, require("plugins.lsp.mason-lspconfig"))
table.insert(plugins, require("plugins.lsp.mason"))
table.insert(plugins, require("plugins.lsp.mason-null-ls"))
table.insert(plugins, require("plugins.lsp.symbols-outline"))

return plugins
