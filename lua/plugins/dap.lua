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

			dap.adapters.go = function(callback, _)
				local handle
				local port = 38697
				handle, _ = vim.loop.spawn("dlv", {
					args = { "dap", "-l", "127.0.0.1:" .. port },
					detached = true,
				}, function(code)
					handle:close()
					print("Delve exited with exit code: " .. code)
				end)
				-- Wait 100ms for delve to start
				vim.defer_fn(function()
					dap.repl.open()
					callback({ type = "server", host = "127.0.0.1", port = port })
				end, 100)
			end

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

			dap.adapters.dlv_spawn = function(cb)
				local stdout = vim.loop.new_pipe(false)
				local handle
				local pid_or_err
				local port = 38697
				local opts = {
					stdio = { nil, stdout },
					args = { "dap", "-l", "127.0.0.1:" .. port },
					detached = true,
				}
				handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
					stdout:close()
					handle:close()
					if code ~= 0 then
						print("dlv exited with code", code)
					end
				end)
				assert(handle, "Error running dlv: " .. tostring(pid_or_err))
				stdout:read_start(function(err, chunk)
					assert(not err, err)
					if chunk then
						vim.schedule(function()
							--- You could adapt this and send `chunk` to somewhere else
							require("dap.repl").append(chunk)
						end)
					end
				end)
				-- Wait for delve to start
				vim.defer_fn(function()
					cb({ type = "server", host = "127.0.0.1", port = port })
				end, 100)
			end

			dap.configurations.go = {
				{
					type = "dlv_spawn",
					name = "Launch dlv & file",
					request = "launch",
					program = "${workspaceFolder}",
				},
				{
					type = "go",
					name = "Debug",
					request = "launch",
					program = "${workspaceFolder}",
				},
				{
					type = "dlv_spawn",
					name = "Debug with arguments",
					request = "launch",
					program = "${workspaceFolder}",
					args = function()
						local args_string = vim.fn.input("Arguments: ")
						return vim.split(args_string, " +")
					end,
				},
				{
					type = "go",
					name = "Debug test",
					request = "launch",
					mode = "test", -- Mode is important
					program = "${file}",
				},
			}

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

	{ "theHamsta/nvim-dap-virtual-text", event = "VeryLazy" },
	{ "mfussenegger/nvim-dap-python", ft = { "python" }, lazy = true },
}
