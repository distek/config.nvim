return {
	"nvim-neotest/neotest",
	dependencies = {
		"akinsho/neotest-go",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local neotest_ns = vim.api.nvim_create_namespace("neotest")
		vim.diagnostic.config({
			virtual_text = {
				format = function(diagnostic)
					local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
					return message
				end,
			},
		}, neotest_ns)

		require("neotest").setup({
			adapters = {
				require("neotest-go"),
			},
			highlights = {
				adapter_name = "Cyan",
				dir = "NeoTreeDirectoryName",
				expand_marker = "NeoTreeExpander",
				failed = "Red",
				focused = "LightMagenta",
				indent = "LightBlack",
				marked = "NeotestMarked",
				namespace = "NeotestNamespace",
				passed = "Green",
				running = "Yellow",
				select_win = "NeotestWinSelect",
				skipped = "NeotestSkipped",
				target = "NeotestTarget",
				test = "NeotestTest",
				unknown = "NeotestUnknown",
				watching = "LightBlue",
			},
		})
	end,
}
