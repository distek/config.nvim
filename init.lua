if vim.g.vscode then
	require("vsc")
else
	require("globals")
	require("plugins")
	require("utils")
	require("keymaps")
	require("autocmds")
end
