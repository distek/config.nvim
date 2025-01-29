return {
	"leoluz/nvim-dap-go",
	event = "VeryLazy",
	ft = { "go" },
	config = function()
		require("dap-go").setup({
			dap_configurations = {
				{
					type = "go",
					name = "Debug Project (Arguments)",
					request = "launch",
					program = "${workspaceFolder}",
					args = function()
						local args_string = vim.fn.input("Args(split by <space>): ")
						return vim.fn.split(args_string, " ", true)
					end,
				},
				{
					type = "go",
					name = "Attach remote",
					mode = "remote",
					request = "attach",
					port = "42069",
					host = "127.0.0.1",
				},
			},
		})
	end,
}
