if vim.g.vscode then
	require("vsc")
else
	require("globals")
	require("plugins")
	if vim.g.neovide then
		require("neovide")
	end
	require("utils")
	require("keymaps")
	require("autocmds")
end
