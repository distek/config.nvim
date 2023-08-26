if vim.g.vscode then
	require("vscode")
else
	local devTainer = require("plugins")

	if not devTainer then
		require("util")
		require("ui")
		require("globals")
		require("autocmds")
		require("mappings")
		if vim.g.neovide then
			require("neovide-settings")
		end
	else
		vim.api.nvim_create_user_command("MasonInstallAll", function()
			vim.cmd("MasonInstall " .. table.concat(require("mason-lspconfig.settings").current.ensure_installed, " "))
		end, {})
	end
end
