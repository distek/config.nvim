return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	event = {
		"BufReadPre " .. vim.fn.expand("~") .. "/Notes/*.md",
		"BufNewFile " .. vim.fn.expand("~") .. "/Notes/*.md",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{
			"<cr>",
			-- leave visual mode to set marks and make ObsidianLink command work
			":ObsidianLinkNew<cr>",
			desc = "Search link",
			ft = "markdown",
			mode = "v",
		},
	},
	opts = {
		workspaces = {
			{
				name = "personal",
				path = "~/Notes",
			},
		},
		ui = {
			enable = false,
		},
		note_id_func = function(title)
			if title == nil then
				return tostring(os.time() .. "-New_Note")
			end

			return title:gsub(" ", "_")
		end,
	},
}
