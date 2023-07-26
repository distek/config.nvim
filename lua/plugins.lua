-- Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local function insert(group, plugins)
	for _, v in ipairs(group) do
		table.insert(plugins, v)
	end

	return plugins
end

local function getPlugins()
	local plugins = {}

	--plugins = insert({
	--	dev = {
	--		-- directory where you store your local plugin projects
	--		path = "~/Programming/neovim-plugs",
	--		---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
	--		patterns = {}, -- For example {"folke"}
	--		fallback = true, -- Fallback to git when local plugin doesn't exist
	--	},
	--}, plugins)

	plugins = insert(require("plugins.filetypes"), plugins)
	plugins = insert(require("plugins.treesitter"), plugins)
	plugins = insert(require("plugins.lsp"), plugins)
	plugins = insert(require("plugins.dap"), plugins)
	plugins = insert(require("plugins.layout"), plugins)
	plugins = insert(require("plugins.misc"), plugins)

	return plugins
end

require("lazy").setup(getPlugins())
