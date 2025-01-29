return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {},
				always_divide_middle = true,
				globalstatus = true,
			},
			sections = {
				lualine_a = {
					{
						function()
							return "▊"
						end,
						padding = { left = 0, right = 0 },
						color = function()
							local utils = require("lualine.utils.utils")

							-- auto change color according to neovims mode
							local colors = {
								normal = utils.extract_color_from_hllist("fg", { "Function" }, "#000000"),
								insert = utils.extract_color_from_hllist("fg", { "String", "MoreMsg" }, "#000000"),
								replace = utils.extract_color_from_hllist("fg", { "Number", "Type" }, "#000000"),
								visual = utils.extract_color_from_hllist(
									"fg",
									{ "Special", "Boolean", "Constant" },
									"#000000"
								),
								command = utils.extract_color_from_hllist("fg", { "Identifier" }, "#000000"),
								back1 = utils.extract_color_from_hllist("bg", { "Normal", "StatusLineNC" }, "#000000"),
								fore = utils.extract_color_from_hllist("fg", { "Normal", "StatusLine" }, "#000000"),
								back2 = utils.extract_color_from_hllist("bg", { "StatusLine" }, "#000000"),
							}

							local mode_color = {
								["n"] = colors.normal, -- 'NORMAL',
								["no"] = colors.normal, -- 'O-PENDING',
								["nov"] = colors.normal, -- 'O-PENDING',
								["noV"] = colors.normal, -- 'O-PENDING',
								["no\22"] = colors.normal, -- 'O-PENDING',
								["niI"] = colors.normal, -- 'NORMAL',
								["niR"] = colors.replace, -- 'NORMAL',
								["niV"] = colors.normal, -- 'NORMAL',
								["nt"] = colors.normal, -- 'NORMAL',
								["v"] = colors.visual, -- 'VISUAL',
								["vs"] = colors.visual, -- 'VISUAL',
								["V"] = colors.visual, -- 'V-LINE',
								["Vs"] = colors.visual, -- 'V-LINE',
								["\22"] = colors.visual, -- 'V-BLOCK',
								["\22s"] = colors.visual, -- 'V-BLOCK',
								["s"] = colors.replace, -- 'SELECT',
								["S"] = colors.replace, -- 'S-LINE',
								["\19"] = colors.replace, -- 'S-BLOCK',
								["i"] = colors.insert, -- 'INSERT',
								["ic"] = colors.insert, -- 'INSERT',
								["ix"] = colors.insert, -- 'INSERT',
								["R"] = colors.replace, -- 'REPLACE',
								["Rc"] = colors.replace, -- 'REPLACE',
								["Rx"] = colors.replace, -- 'REPLACE',
								["Rv"] = colors.replace, -- 'V-REPLACE',
								["Rvc"] = colors.replace, -- 'V-REPLACE',
								["Rvx"] = colors.replace, -- 'V-REPLACE',
								["c"] = colors.command, -- 'COMMAND',
								["cv"] = colors.command, -- 'EX',
								["ce"] = colors.command, -- 'EX',
								["r"] = colors.replace, -- 'REPLACE',
								["rm"] = colors.replace, -- 'MORE',
								["r?"] = colors.insert, -- 'CONFIRM',
								["!"] = colors.command, -- 'SHELL',
								["t"] = colors.insert, -- 'TERMINAL',
							}
							return {
								fg = mode_color[vim.fn.mode()],
								bg = colors.back1,
							}
						end,
					},
				},
				lualine_b = {
					"branch",
					"diff",
					"diagnostics",
				},
				lualine_c = {
					{
						function()
							local stl = require("edgy-group.stl")
							local bottom_line = stl.get_statusline("bottom")
							return table.concat(bottom_line)
						end,
					},
				},
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = {
					{
						"location",
						color = {
							fg = require("lualine.utils.utils").extract_color_from_hllist(
								"bg",
								{ "Normal" },
								"#000000"
							),
							bg = require("lualine.utils.utils").extract_color_from_hllist(
								"fg",
								{ "Special", "Boolean", "Constant" },
								"#000000"
							),
						},
					},
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = {},
		})
	end,
}

-- return {
-- 	"echasnovski/mini.statusline",
-- 	version = "*",
-- 	config = function()
-- 		require("mini.statusline").setup()
-- 	end,
-- }
