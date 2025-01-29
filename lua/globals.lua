vim.cmd("colorscheme retrobox")
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.o.autoread = true
vim.backspace = { "indent", "eol", "start" }
vim.o.breakindent = true
vim.o.bufhidden = "hide"
vim.o.clipboard = "unnamedplus"
vim.o.cmdheight = 1
vim.wo.colorcolumn = "0"
vim.o.cmdheight = 1
vim.wo.colorcolumn = "0"
vim.o.conceallevel = 2
vim.o.cursorline = true
vim.o.encoding = "utf-8"
vim.o.expandtab = true
vim.o.fileformats = "unix,dos,mac"
vim.cmd([[filetype plugin indent on]])
vim.o.hidden = true
vim.o.hlsearch = true
-- vim.o.ignorecase = true
vim.o.inccommand = "nosplit"
vim.o.incsearch = true
vim.opt.laststatus = 2
vim.o.linebreak = true
vim.o.modeline = true
vim.o.modelines = 5
vim.opt.mouse = "a"
vim.o.number = true
vim.o.numberwidth = 8
vim.o.pumblend = 15
vim.o.relativenumber = true
vim.o.ruler = true
vim.o.scrolloff = 2
vim.opt.fillchars = {
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vert = "┃",
	vertleft = "┫",
	vertright = "┣",
	verthoriz = "╋",
	fold = "─",
	eob = " ",
}

vim.o.shell = os.getenv("SHELL")
vim.o.shiftwidth = 4
vim.opt.shortmess:append("I")
vim.o.showbreak = "  "
vim.o.showmode = false
vim.o.showtabline = 2
vim.o.smartcase = true
vim.o.softtabstop = 0
vim.opt.spell = false
vim.opt.spelllang = { "en_us" }
vim.opt.splitkeep = "screen"
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.startofline = false
vim.o.swapfile = false
vim.o.syntax = "off"
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.timeoutlen = 250
vim.o.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
vim.o.undofile = true
vim.o.updatetime = 250
vim.o.wildignore = "*.o,*.obj,.git,*.rbc,*.pyc,__pycache__"
vim.o.wildmode = "list:longest,list:full"
vim.o.wrap = true

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_hide = 0
vim.g.netrw_altv = 1
vim.g.netrw_altfile = 1
vim.g.netrw_browse_split = 4
vim.g.netrw_fastbrowse = 2
vim.g.netrw_keepdir = 1

-- Disabled builtins
-- Improves startup time just ever so slightly
local disabled_built_ins = {
	-- Need netrw for certain things, like remote editing
	-- "netrw",
	-- "netrwPlugin",
	-- "netrwSettings",
	-- "netrwFileHandlers",
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"spellfile_plugin",
	"matchit",
}

for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or "single"
	opts.max_width = opts.max_width or 80
	opts.max_height = opts.max_height or 20
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

vim.o.tabline = "%!v:lua.TabLine()"

_G.TabLine = function()
	local s = ""
	for tabnr = 1, vim.fn.tabpagenr("$") do
		local cwd = vim.fn.fnamemodify(vim.fn.getcwd(-1, tabnr), ":t")
		if tabnr == vim.fn.tabpagenr() then
			s = s .. "%#TabLineSel#" .. " " .. cwd .. " "
		else
			s = s .. "%#TabLine#" .. " " .. cwd .. " "
		end
	end
	s = s .. "%#TabLineFill#"
	return s
end
