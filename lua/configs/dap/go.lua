return function()
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
		},
	})
end
