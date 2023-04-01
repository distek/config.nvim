if vim.g.vscode then
	require("vscode")
else
	require("plugins")
	require("util")
	require("themes")
	require("terminal")
	require("statuscolumn")
	require("globals")
	require("autocmds")
	require("mappings")
	if vim.g.neovide then
		require("neovide-settings")
	end
end
