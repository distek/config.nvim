M = {}
local port = 6005
local cmd = vim.lsp.rpc.connect("127.0.0.1", port)
local pipe = "/tmp/godot.pipe" -- I use /tmp/godot.pipe

GodotLSPConnected = false

function M:StartGodotLSP()
	vim.lsp.start({
		name = "Godot",
		cmd = cmd,
		root_dir = vim.fs.dirname(
			vim.fs.find({ "project.godot", ".git" }, { upward = true })[1]
		),
		on_attach = function(client, bufnr)
			if GodotLSPConnected == false then
				vim.api.nvim_command('echo serverstart("' .. pipe .. '")')
				GodotLSPConnected = true
			end
		end,
	})
end

return M
