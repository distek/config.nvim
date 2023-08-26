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

	plugins = insert(require("plugins.filetypes"), plugins)
	plugins = insert(require("plugins.treesitter"), plugins)
	plugins = insert(require("plugins.lsp"), plugins)
	plugins = insert(require("plugins.dap"), plugins)
	plugins = insert(require("plugins.layout"), plugins)
	plugins = insert(require("plugins.misc"), plugins)

	return plugins
end

function Update()
	require("lazy").sync()
	vim.cmd("TSUpdate")
end

local devTainer = function()
	if os.getenv("DEVTAINER_BUILD") ~= "" then
		return true
	end

	return false
end

require("lazy").setup(getPlugins(), { install = { missing = not devTainer() } })

if not devTainer() then
	vim.api.nvim_create_autocmd({ "LazySync" }, {
		callback = function()
			vim.cmd("q")
		end,
	})
end
