return {
	"hrsh7th/vim-vsnip",
	config = function()
		vim.g.vsnip_snippet_dir = vim.fn.expand('~') .. "/.config/nvim/lua/snippets/"
	end
}
