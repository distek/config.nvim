if vim.g.vscode then
	require("extra.vsc")
else
	require("plugins")

	require("util")
	require("ui")
	require("globals")
	require("autocmds")
	require("mappings")
end
