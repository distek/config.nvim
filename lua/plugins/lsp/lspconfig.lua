return {
	"neovim/nvim-lspconfig",
	config = function()
		local lspconfig = require("lspconfig")

		-- Aesthetics
		local signs = {
			Error = " ",
			Warning = " ",
			Hint = " ",
			Information = " ",
		}

		for type, icon in pairs(signs) do
			local hl = "LspDiagnosticsSign" .. type

			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		local handlers = {
			["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" }),
			["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" }),
		}

		vim.diagnostic.config({
			virtual_text = {
				source = true, -- Or "if_many"
			},
			float = {
				source = true, -- Or "if_many"
			},
		})

		require("mason").setup({
			ui = {
				icons = {
					server_installed = "✓",
					server_pending = "➜",
					server_uninstalled = "✗",
				},
			},
		})

		require("mason-lspconfig").setup({
			automatic_installation = true,
		})

		local lsp_formatting = function(bufnr)
			vim.lsp.buf.format({
				filter = function(client)
					local doFormat = true
					if client.name == "tsserver" then
						return false
					end
					return doFormat
				end,
				bufnr = bufnr,
			})
		end

		-- if you want to set up formatting on save, you can use this as a callback
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		-- add to your shared on_attach callback
		local on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						lsp_formatting(bufnr)
					end,
				})
			end
		end

		vim.lsp.config("*", {
			root_markers = { ".git" },
			on_attach = on_attach,
		})
		vim.lsp.config("buf_ls", {
			filetypes = { "proto" },
		})
		vim.lsp.enable("buf_ls")
		-- vim.lsp.enable("llm-ls")

		-- vim.lsp.config("llm-ls", {
		-- 	filetypes = { "*" },
		-- })

		vim.lsp.config(
			"clangd",
			(function()
				local capabilities = vim.lsp.protocol.make_client_capabilities()
				-- capabilities.offsetEncoding = { "utf-16" }
				-- capabilities.textDocument.formatting.dynamicRegistration = false
				-- capabilities.textDocument.rangeFormatting.dynamicRegistration = true

				return {
					cmd = {
						vim.fn.expand("~/.local/share/nvim/mason/bin/clangd"),
						"--cross-file-rename",
						"--fallback-style=NONE",
					},
					filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
					capabilities = capabilities,
					handlers = handlers,
				}
			end)()
		)
		vim.lsp.enable("clangd")

		vim.lsp.config(
			"cssls",
			(function()
				local capabilities = vim.lsp.protocol.make_client_capabilities()
				capabilities.textDocument.completion.completionItem.snippetSupport = true
				return {
					capabilities = capabilities,
					handlers = handlers,
				}
			end)()
		)
		vim.lsp.enable("cssls")

		vim.lsp.enable("gopls")
		-- vim.lsp.start({
		-- 	name = "gopls",
		-- 	cmd = "gopls",
		-- 	on_attach = function(client, bufnr)
		-- 		vim.lsp.completion.enable(true, client.id, bufnr, {
		-- 			autotrigger = true,
		-- 			convert = function(item)
		-- 				return { abbr = item.label:gsub("%b()", "") }
		-- 			end,
		-- 		})
		-- 	end,
		-- })

		vim.lsp.config(
			"lua_ls",
			(function()
				local runtime_path = vim.split(package.path, ";")
				table.insert(runtime_path, "lua/?.lua")
				table.insert(runtime_path, "lua/?/init.lua")

				local library = vim.api.nvim_get_runtime_file("", true)

				return {
					settings = {
						Lua = {
							runtime = {
								-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
								version = "LuaJIT",
								-- Setup your lua path
								path = runtime_path,
							},
							diagnostics = {
								-- Get the language server to recognize the `vim` global
								globals = { "renoise", "vim" },
							},
							workspace = { -- Make the server aware of Neovim runtime files
								library = library,
								checkThirdParty = false,
							},
							-- Do not send telemetry data containing a randomized but unique identifier
							telemetry = {
								enable = false,
							},
							format = {
								enable = true,
								-- Put format options here
								-- NOTE: the value should be STRING!!
								defaultConfig = {
									indent_style = "space",
									indent_size = "2",
								},
							},
						},
					},
					handlers = handlers,
				}
			end)()
		)

		vim.lsp.config(
			"vtsls",
			(function()
				return {
					settings = {
						typescript = {
							format = {
								enable = false, -- Disable vtsls formatting
							},
						},
						javascript = {
							format = {
								enable = false, -- Disable vtsls formatting
							},
						},
					},
				}
			end)()
		)

		-- ["tsserver", {
		-- 	local capabilities = vim.lsp.protocol.make_client_capabilities()

		-- 	local capabilitiesWithoutFomatting =
		-- 		vim.lsp.protocol.make_client_capabilities()
		-- 	capabilitiesWithoutFomatting.textDocument.formatting = false
		-- 	capabilitiesWithoutFomatting.textDocument.rangeFormatting = false
		-- 	capabilitiesWithoutFomatting.textDocument.range_formatting = false
		-- 	capabilitiesWithoutFomatting.documentFormattingProvider = false
		-- 	capabilitiesWithoutFomatting.documentRangeFormattingProvider = false

		-- 	lspconfig.tsserver.setup({
		-- 		capabilities = capabilitiesWithoutFomatting,
		-- 		settings = {
		-- 			documentFormatting = false,
		-- 		},
		-- 		handlers = handlers,
		-- 	})
		-- end,

		-- lspconfig.sourcekit.setup({
		--     capabilities = {
		--         workspace = {
		--             didChangeWatchedFiles = {
		--                 dynamicRegistration = true,
		--             },
		--         },
		--     },
		-- })

		require("mason-null-ls").setup({
			automatic_installation = false,
			automatic_setup = true, -- Recommended, but optional
			handlers = handlers,
		})
		local null_ls = require("null-ls")

		local b = null_ls.builtins

		local sources = {
			-- b.formatting.clang_format.with({
			-- 	extra_args = {
			-- 		"--style",
			-- 		"{UseTab: Always, IndentWidth: 8, TabWidth: 8, ColumnLimit: 90, NamespaceIndentation: All}",
			-- 	},
			-- }),
			b.formatting.prettierd.with({
				cwd = require("null-ls.helpers").cache.by_bufnr(function(params)
					return require("null-ls.utils").root_pattern(
					-- https://prettier.io/docs/en/configuration.html
						"*/.prettierrc",
						"*/.prettierrc.json",
						"*/.prettierrc.yml",
						"*/.prettierrc.yaml",
						"*/.prettierrc.json5",
						"*/.prettierrc.js",
						"*/.prettierrc.cjs",
						"*/.prettierrc.toml",
						"*/prettier.config.js",
						"*/prettier.config.cjs",
						"*/package.json",
						".prettierrc",
						".prettierrc.json",
						".prettierrc.yml",
						".prettierrc.yaml",
						".prettierrc.json5",
						".prettierrc.js",
						".prettierrc.cjs",
						".prettierrc.toml",
						"prettier.config.js",
						"prettier.config.cjs",
						"package.json"
					)(params.bufname)
				end),
			}),
		}

		null_ls.setup({
			debug = true,
			sources = sources,
		})

		null_ls.deregister(null_ls.builtins.formatting.codespell)

		null_ls.disable("proto")
		null_ls.disable("lua")
		-- null_ls.disable("go")
		null_ls.disable("typescript")
		null_ls.disable("java")
	end,
}
