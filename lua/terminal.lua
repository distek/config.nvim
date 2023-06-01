-- NeoTreeToggle = false
-- TF = require("nvim-terminal")
-- TF.setup({
-- 	termlist = true,
-- 	termlist_side = "right",
-- 	focus_on_select = false,
-- 	winbar_tabs = false,

-- 	pre_cb = function()
-- 		NeoTreeToggle = Util.is_neotree_open()

-- 		if NeoTreeToggle then
-- 			vim.cmd("NeoTreeShowToggle")
-- 		end
-- 	end,

-- 	post_cb = function()
-- 		if NeoTreeToggle then
-- 			vim.cmd("NeoTreeShowToggle")
-- 			NeoTreeToggle = false
-- 		end
-- 	end,

-- 	terminal_bg = Util.darken(Util.getColor("Normal", "bg"), 0.70),

-- 	terminal_list_bg = Util.darken(Util.getColor("Normal", "bg"), 0.80),
-- })
