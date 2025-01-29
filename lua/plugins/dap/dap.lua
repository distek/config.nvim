return {
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	config = function()
		local dap = require("dap")

		vim.fn.sign_define("DapBreakpoint", {
			text = "",
			texthl = "DapBreakpoint",
			numhl = "DapBreakpoint",
		})
		vim.fn.sign_define("DapBreakpointCondition", {
			text = "",
			texthl = "DapBreakpoint",
			numhl = "DapBreakpoint",
		})
		vim.fn.sign_define("DapBreakpointRejected", {
			text = "",
			texthl = "DapBreakpoint",
			numhl = "DapBreakpoint",
		})
		vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", numhl = "DapLogPoint" })
		vim.fn.sign_define("DapStopped", {
			text = "",
			texthl = "DapStopped",
			linehl = "DapStopped",
			numhl = "DapStopped",
		})

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

		dap.adapters.lldb = {
			-- type = "executable",
			-- command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
			-- args = { "--port", "12345" },
			--
			-- name = "lldb",
			-- type = "server",
			-- host = "127.0.0.1",
			-- port = 12345,
			--
			type = "server",
			port = "${port}",
			executable = {
				-- CHANGE THIS to your path!
				command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
				args = { "--port", "${port}" },

				-- On windows you may have to uncomment this:
				-- detached = false,
			},
		}

		dap.configurations.c = {
			{
				name = "Launch",
				type = "lldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
			},
		}

		dap.configurations.cpp = dap.configurations.c

		require("nvim-dap-virtual-text").setup({})
	end,
}
