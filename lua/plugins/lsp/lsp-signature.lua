return {
	"ray-x/lsp_signature.nvim",
	event = "InsertEnter",
	config = function()
		require("lsp_signature").setup({
			bind = true, -- This is mandatory, otherwise border config won't get registered.
			-- handler_opts = {
			-- 	border = "shadow",
			-- },
			hint_enable = true,
			hint_prefix = "> ",
		})
	end,
}
