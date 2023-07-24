return {
	-- DAP
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		config = function()
			local dap = require("dap")

			vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "red" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "ﳁ", texthl = "blue" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "red" })
			vim.fn.sign_define("DapLogPoint", { text = "", texthl = "yellow" })
			vim.fn.sign_define("DapStopped", { text = "", texthl = "green" })

			-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
			require("dapui").setup({
				icons = { expanded = "▾", collapsed = "▸" },
				mappings = {
					-- use(a table to apply multiple mappings
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
				},
				layouts = {
					{
						elements = {
							"scopes",
							"breakpoints",
							"stacks",
							"watches",
						},
						size = 40,
						position = "left",
					},
					{
						elements = {
							"repl",
							"console",
						},
						size = 10,
						position = "bottom",
					},
				},
				controls = {
					-- Requires Neovim nightly (or 0.8 when released)
					enabled = true,
					-- Display controls in this element
					element = "console",
					icons = {
						pause = "",
						play = "",
						step_into = "",
						step_over = "",
						step_out = "",
						step_back = "",
						run_last = "",
						terminate = "",
					},
				},
				floating = {
					max_height = 1, -- These can be integers or a float between 0 and 1.
					max_width = 19, -- Floats will be treated as percentage of your screen.
					border = "single", -- Border style. Can be "single", "double" or "rounded"
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				windows = { indent = 1 },
			})

			dap.configurations.c = {
				{
					name = "codelldb server",
					type = "server",
					port = "${port}",
					executable = {
						command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
						args = { "--port", "${port}" },
					},
				},
			}

			require("nvim-dap-virtual-text").setup({})
		end,
	},

	{ "rcarriga/nvim-dap-ui", event = "VeryLazy" },
	{
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
				},
			})
		end,
	},

	{ "theHamsta/nvim-dap-virtual-text", event = "VeryLazy" },
	{ "mfussenegger/nvim-dap-python", ft = { "python" }, lazy = true },
}
