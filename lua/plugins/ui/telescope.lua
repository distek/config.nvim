return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-telescope/telescope-dap.nvim",
	},
	config = require("configs.ui.telescope"),
}
