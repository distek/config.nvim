return function()
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
			{
				name = "look",
				keyword_length = 2,
				options = { convert_case = true, loud = true },
			},
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

	require("luasnip.loaders.from_vscode").lazy_load()
	require("luasnip.loaders.from_snipmate").lazy_load()
end
