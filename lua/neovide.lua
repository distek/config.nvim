vim.opt.guifont = "JetBrainsMono Nerd Font Mono:h12"

vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_underline_automatic_scaling = true
vim.g.neovide_refresh_rate = 60
vim.g.neovide_refresh_rate_idle = 5
vim.g.neovide_confirm_quit = true
vim.g.neovide_remember_window_size = false
vim.g.neovide_input_use_logo = false
vim.g.neovide_input_macos_option_key_is_meta = "both"

local map = vim.keymap.set

local function neovideScale(amount)
	local temp = vim.g.neovide_scale_factor + amount

	if temp < 0.5 then
		return
	end

	vim.g.neovide_scale_factor = temp
end

map("n", "<C-=>", function()
	neovideScale(0.1)
end)

map("n", "<C-->", function()
	neovideScale(-0.1)
end)

map("n", "<C-S-V>", '"+P') -- Paste normal mode
map("t", "<C-S-V>", '<C-\\><C-n>l"+Pli') -- Paste normal mode
map("v", "<C-S-V>", '"+P') -- Paste visual mode
map("c", "<C-S-V>", "<C-R>+") -- Paste command mode
map("i", "<C-S-V>", '<ESC>l"+Pli') -- Paste insert mode
