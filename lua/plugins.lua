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

local function bootstrap()
	if os.getenv("DEVTAINER_BUILD") ~= nil then
		return true
	end

	return false
end

require("lazy").setup(getPlugins())

if bootstrap() then
	local ensure_installed = {
		"bash-language-server",
		"clang-format",
		"clangd",
		"css-lsp",
		"goimports",
		"golangci-lint",
		"gopls",
		"jq",
		"json-lsp",
		"lua-language-server",
		"prettierd",
		"prettierd",
		"rust-analyzer",
		"shfmt",
		"stylua",
		"typescript-language-server",
	}

	require("mason.api.command").MasonInstall(ensure_installed, {})
end
