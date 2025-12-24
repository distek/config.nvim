-- Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local doBootstrap = false

if vim.loop.fs_stat(lazypath) == nil then
    vim.print("Boostrapping lazy")
    vim.system({"mkdir", "-p", lazypath}):wait()
	vim.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	}, {text = true}, function(obj)
        vim.print(obj)
    end):wait()

	doBootstrap = true
end

vim.opt.rtp:prepend(lazypath)

local function insert(plugins, group)
	for _, v in ipairs(group) do
		table.insert(plugins, v)
	end

	return plugins
end

local function getPlugins()
	local plugins = {}

	plugins = insert(plugins, require("plugins.deps"))
	plugins = insert(plugins, require("plugins.filetype"))
	plugins = insert(plugins, require("plugins.treesitter"))
	plugins = insert(plugins, require("plugins.lsp"))
	plugins = insert(plugins, require("plugins.dap"))
	plugins = insert(plugins, require("plugins.ui"))
	plugins = insert(plugins, require("plugins.misc"))

	local stat = vim.loop.fs_stat(vim.fn.stdpath("config") .. "/lua/plugins/work/init.lua")
	if stat and stat.type == "file" then
		plugins = insert(plugins, require("plugins.work"))
	end

	return plugins
end

local function bootstrap()
	if os.getenv("DEVTAINER_BUILD") ~= nil or doBootstrap then
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
		"codelldb",
		"csharp-language-server",
		"css-lsp",
		"goimports",
		"golangci-lint",
		"gopls",
		"java-language-server",
		"jq",
		"json-lsp",
		"lua-language-server",
		"prettierd",
		"pyright",
		"rust-analyzer",
		"shfmt",
		"stylua",
		"tailwindcss-language-server",
		"templ",
		"typescript-language-server",
	}

	require("mason.api.command").MasonInstall(ensure_installed, {})
end
