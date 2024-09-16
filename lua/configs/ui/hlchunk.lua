return function()
	local exclude = function()
		local t = {
			"neo-tree",
			"starter",
			"Outline",
			"scratch",
			"termlist",
			"toggleterm",
		}

		local tb = {}

		for _, v in ipairs(t) do
			tb[v] = true
		end

		return tb
	end
	require("hlchunk").setup({
		indent = {
			enable = true,
			exclude_filetypes = exclude(),
			use_treesitter = false,
			chars = {
				"│",
			},
			style = {
				{
					fg = vim.fn.synIDattr(
						vim.fn.synIDtrans(vim.fn.hlID("NeoTreeDimText")),
						"fg",
						"gui"
					),
				},
			},
		},

		chunk = {
			enable = true,
			notify = false,
			chars = {
				horizontal_line = "─",
				vertical_line = "│",
				left_top = "╭",
				left_bottom = "╰",
				right_arrow = "─",
			},
			exclude_filetypes = {
				["neo-tree"] = true,
				["starter"] = true,
				["Outline"] = true,
			},
			style = {
				{
					fg = vim.fn.synIDattr(
						vim.fn.synIDtrans(vim.fn.hlID("HLChunkIndicator")),
						"fg",
						"gui"
					),
				},
			},

			use_treesitter = false,
		},

		line_num = {
			enable = false,
		},

		blank = {
			enable = false,
		},
	})
end
