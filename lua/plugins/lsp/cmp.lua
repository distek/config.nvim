return {
	"hrsh7th/nvim-cmp",
	dependencies = {
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

		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

		cmp.setup({
			snippet = {},
			formatting = {
				format = require("lspkind").cmp_format({
					with_text = true,
					maxwidth = 50,
					menu = {
						buffer = "[Buffer]",
						nvim_lsp = "[LSP]",
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
				["<C-e>"] = cmp.mapping.abort(),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			preselect = cmp.PreselectMode.None,
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "nvim_lua" },
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
					border = "single",
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
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				}),
			},
		})
	end,
}
