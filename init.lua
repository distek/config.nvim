if vim.g.vscode then
	require("extra.vsc")
else
	require("plugins")
	if vim.g.neovide then
		require("extra.neovide-settings")
	end
	require("util")
	require("ui")
	require("globals")
	require("autocmds")
	require("mappings")
end
