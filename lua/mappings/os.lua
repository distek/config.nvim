local map = vim.keymap.set

if vim.uv.os_uname().sysname == "Darwin" then
	map("n", "gx", 'yiW:!open <C-R>"<CR><Esc>')
elseif vim.uv.os_uname().sysname == "Linux" then
	map("n", "gx", 'yiW:!xdg-open <C-R>"<CR><Esc>')
end
