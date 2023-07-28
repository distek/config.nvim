return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")

			-- Formatting
			-- Map :Format to vim.lsp.buf.formatting()
			vim.cmd([[command! Format execute 'lua vim.lsp.buf.format { async = true }']])

			-- Aesthetics
			local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

			for type, icon in pairs(signs) do
				local hl = "LspDiagnosticsSign" .. type

				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

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
				ensure_installed = { "bashls", "clangd", "cssls", "gopls", "lua_ls", "tsserver", "vls" },
				automatic_installation = true,
			})

			require("mason-lspconfig").setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({})
					require("lsp_signature").on_attach()
				end,
				["clangd"] = function()
					local capabilities = vim.lsp.protocol.make_client_capabilities()

					capabilities.offsetEncoding = { "utf-16" }
					capabilities.textDocument.formatting = false
					capabilities.textDocument.rangeFormatting = false
					capabilities.textDocument.range_formatting = false

					lspconfig.clangd.setup({
						cmd = {
							vim.fn.expand("~/.local/share/nvim/mason/bin/clangd"),
							"--cross-file-rename",
						},
						filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
						capabilities = capabilities,
					})
				end,
				["cssls"] = function()
					local capabilities = vim.lsp.protocol.make_client_capabilities()
					capabilities.textDocument.completion.completionItem.snippetSupport = true
					lspconfig.cssls.setup({
						capabilities = capabilities,
					})
				end,
				["gopls"] = function()
					lspconfig.gopls.setup({
						root_dir = lspconfig.util.root_pattern("go.mod", ".git", "main.go"),
					})
				end,
				["lua_ls"] = function()
					local runtime_path = vim.split(package.path, ";")
					table.insert(runtime_path, "lua/?.lua")
					table.insert(runtime_path, "lua/?/init.lua")

					local library = vim.api.nvim_get_runtime_file("", true)

					table.insert(
						library,
						"/Users/jacob_fralick/.local/share/nvim/mason/packages/lua-language-server/libexec/meta/5393ac01"
					)

					lspconfig.lua_ls.setup({
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
									globals = { "vim" },
								},
								workspace = {
									-- Make the server aware of Neovim runtime files
									library = library,
									checkThirdParty = false,
								},
								-- Do not send telemetry data containing a randomized but unique identifier
								telemetry = {
									enable = false,
								},
								format = {
									enable = false,
									-- Put format options here
									-- NOTE: the value should be STRING!!
									defaultConfig = {
										indent_style = "space",
										indent_size = "2",
									},
								},
							},
						},
					})
				end,
				["tsserver"] = function()
					local capabilities = vim.lsp.protocol.make_client_capabilities()

					local capabilitiesWithoutFomatting = vim.lsp.protocol.make_client_capabilities()
					capabilitiesWithoutFomatting.textDocument.formatting = false
					capabilitiesWithoutFomatting.textDocument.rangeFormatting = false
					capabilitiesWithoutFomatting.textDocument.range_formatting = false
					capabilitiesWithoutFomatting.documentFormattingProvider = false
					capabilitiesWithoutFomatting.documentRangeFormattingProvider = false

					lspconfig.tsserver.setup({
						capabilities = capabilitiesWithoutFomatting,
						settings = {
							documentFormatting = false,
						},
					})
				end,
				["vls"] = function()
					local trimmedCapabilities = vim.lsp.protocol.make_client_capabilities()

					lspconfig.vls.setup({
						capabilities = trimmedCapabilities,
					})
				end,
			})

			require("mason-null-ls").setup({
				ensure_installed = {
					"clang_format",
					"goimports",
					"golangci_lint",
					"jq",
					"prettierd",
					"rust_analyzer",
					"shfmt",
					"stylua",
				},
				automatic_installation = true,
				automatic_setup = true, -- Recommended, but optional
				handlers = {},
			})

			local null_ls = require("null-ls")

			local b = null_ls.builtins

			local sources = {
				b.formatting.clang_format.with({
					extra_args = {
						"--style",
						"{UseTab: Always, IndentWidth: 8, TabWidth: 8}",
					},
				}),
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
		end,
	},

	{ "williamboman/mason.nvim", event = "BufReadPre" },
	{ "williamboman/mason-lspconfig.nvim", event = "BufReadPre" },

	{
		"jayp0521/mason-null-ls.nvim",
		event = "BufReadPre",
		dependencies = {
			"jose-elias-alvarez/null-ls.nvim",
		},
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-look",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-calc",
			"hrsh7th/cmp-nvim-lua",
			"uga-rosa/cmp-dictionary",
			"hrsh7th/vim-vsnip",
			"rafamadriz/friendly-snippets",
			"honza/vim-snippets",
		},
		event = { "InsertEnter", "CmdlineEnter" },
		config = function()
			local cmp = require("cmp")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local luasnip = require("luasnip")

			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				formatting = {
					format = require("lspkind").cmp_format({
						with_text = true,
						maxwidth = 50,
						menu = {
							buffer = "[Buffer]",
							nvim_lsp = "[LSP]",
							luasnip = "[Luasnip]",
							nvim_lua = "[Lua]",
							look = "[Look]",
							spell = "[Spell]",
							path = "[Path]",
							calc = "[Calc]",
						},
					}),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = false,
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				preselect = cmp.PreselectMode.None,
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "look", keyword_length = 2, options = { convert_case = true, loud = true } },
					{ name = "path" },
					{ name = "calc" },
					{ name = "dictionary" },
				}),
				window = {
					completion = {
						winhighlight = "Normal:NoiceCmdLine,FloatBorder:FloatBorder,CursorLine:Visual",
						border = "shadow",
					},
					documentation = {
						winhighlight = "Normal:NoiceCmdLine,FloatBorder:FloatBorder,CursorLine:Visual",
						border = "shadow",
					},
				},
			})

			require("cmp").setup.cmdline(":", {
				sources = {
					{ name = "cmdline" },
					{ name = "path" },
				},
				mapping = {
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end, { "c" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { "c" }),
				},
			})
			-- require("cmp").setup.cmdline("@", {
			-- 	sources = cmp.config.sources({
			-- 		{ name = "cmdline" },
			-- 		{ name = "path" },
			-- 	}),
			-- 	mapping = {
			-- 		["<Tab>"] = cmp.mapping(function(fallback)
			-- 			if cmp.visible() then
			-- 				cmp.select_next_item()
			-- 			else
			-- 				fallback()
			-- 			end
			-- 		end, { "c" }),
			-- 		["<S-Tab>"] = cmp.mapping(function(fallback)
			-- 			if cmp.visible() then
			-- 				cmp.select_prev_item()
			-- 			else
			-- 				fallback()
			-- 			end
			-- 		end, { "c" }),
			-- 	},
			-- })

			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_snipmate").lazy_load()
		end,
	},

	{ "onsails/lspkind-nvim", event = "InsertEnter" },

	{
		"dnlhc/glance.nvim",
		event = "VeryLazy",
		cmd = "Glance",
		config = function()
			require("glance").setup({
				border = {
					enable = true, -- Show window borders. Only horizontal borders allowed
					top_char = "―",
					bottom_char = "―",
				},
			})
		end,
	},

	{
		"simrat39/symbols-outline.nvim",
		event = "VeryLazy",
		config = function()
			require("symbols-outline").setup({
				highlight_hovered_item = true,
				show_guides = true,
				auto_preview = false,
				position = "right",
				relative_width = true,
				width = 35,
				auto_close = false,
				show_numbers = false,
				show_relative_numbers = false,
				show_symbol_details = true,
				preview_bg_highlight = "Pmenu",
				autofold_depth = nil,
				auto_unfold_hover = true,
				fold_markers = { "", "" },
				wrap = false,
				keymaps = { -- These keymaps can be a string or a table for multiple keys
					close = { "q" },
					goto_location = "<Cr>",
					focus_location = "o",
					hover_symbol = "<C-space>",
					toggle_preview = "K",
					rename_symbol = "r",
					code_actions = "a",
					fold = "zc",
					unfold = "zo",
					fold_all = "zM",
					unfold_all = "zR",
					fold_reset = "R",
				},
				lsp_blacklist = {},
				symbol_blacklist = {},
				-- symbols = {
				-- 	File = { icon = "", hl = "TSURI" },
				-- 	Module = { icon = "", hl = "TSNamespace" },
				-- 	Namespace = { icon = "", hl = "TSNamespace" },
				-- 	Package = { icon = "", hl = "TSNamespace" },
				-- 	Class = { icon = "𝓒", hl = "TSType" },
				-- 	Method = { icon = "ƒ", hl = "TSMethod" },
				-- 	Property = { icon = "", hl = "TSMethod" },
				-- 	Field = { icon = "", hl = "TSField" },
				-- 	Constructor = { icon = "", hl = "TSConstructor" },
				-- 	Enum = { icon = "ℰ", hl = "TSType" },
				-- 	Interface = { icon = "ﰮ", hl = "TSType" },
				-- 	Function = { icon = "", hl = "TSFunction" },
				-- 	Variable = { icon = "", hl = "TSConstant" },
				-- 	Constant = { icon = "", hl = "TSConstant" },
				-- 	String = { icon = "𝓐", hl = "TSString" },
				-- 	Object = { icon = "⦿", hl = "TSType" },
				-- 	Key = { icon = "🔐", hl = "TSType" },
				-- 	Number = { icon = "#", hl = "TSNumber" },
				-- 	Boolean = { icon = "⊨", hl = "TSBoolean" },
				-- 	Array = { icon = "", hl = "TSConstant" },
				-- 	Null = { icon = "NULL", hl = "TSType" },
				-- 	EnumMember = { icon = "", hl = "TSField" },
				-- 	Struct = { icon = "𝓢", hl = "TSType" },
				-- 	Event = { icon = "🗲", hl = "TSType" },
				-- 	Operator = { icon = "+", hl = "TSOperator" },
				-- 	TypeParameter = { icon = "𝙏", hl = "TSParameter" },
				-- },
			})
		end,
	},

	{
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
		config = function()
			require("lsp_signature").setup()
		end,
	},
}
