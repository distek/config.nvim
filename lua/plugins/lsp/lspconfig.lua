return {
	"neovim/nvim-lspconfig",
	config = function()
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

		vim.diagnostic.config({
			virtual_text = {
				source = true,
			},
			float = {
				source = true,
			},
		})

		vim.lsp.config("*", {
			root_markers = { ".git", "main.*", "go.mod" },
		})

		vim.lsp.config("buf_ls", {
			filetypes = { "proto" },
		})

		vim.lsp.enable("buf_ls")

		vim.lsp.config(
			"clangd",
			(function()
				return {
					cmd = {
						vim.fn.expand("~/.local/share/nvim/mason/bin/clangd"),
						"--cross-file-rename",
						"--fallback-style=NONE",
					},
					filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
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
				}
			end)()
		)
		vim.lsp.enable("cssls")

		vim.lsp.enable("gopls")

		vim.lsp.config(
			"lua_ls",
			(function()
				local runtimePath = vim.split(package.path, ";")
				table.insert(runtimePath, "lua/?.lua")
				table.insert(runtimePath, "lua/?/init.lua")

				local library = vim.api.nvim_get_runtime_file("", true)

				return {
					settings = {
						Lua = {
							runtime = {
								version = "LuaJIT",
								path = runtimePath,
							},
							diagnostics = {
								globals = { "renoise", "vim" },
							},
							workspace = {
								library = library,
								checkThirdParty = false,
							},
							telemetry = {
								enable = false,
							},
							format = {
								enable = true,
								-- To not fuck up other people's projects
								-- I will note that 2 space indenting is the devil
								defaultConfig = {
									indent_style = "space",
									indent_size = "2",
								},
							},
						},
					},
				}
			end)()
		)

		vim.lsp.config("ols", {
			mason = false,
			cmd = { vim.fn.stdpath("data") .. "/mason/packages/ols/ols-arm64-darwin" },
			settings = {},
		})

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

		-- Null-ls
		require("mason-null-ls").setup({
			automatic_installation = false,
			automatic_setup = true, -- Recommended, but optional
			-- handlers = handlers,
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
