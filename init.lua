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
	end
end
