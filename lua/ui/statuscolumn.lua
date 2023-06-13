local gitsigns_bar = "▌"

local gitsigns_hl_pool = {
	GitSignsAdd = "GitSignsAdd",
	GitSignsChange = "GitSignsChange",
	GitSignsChangedelete = "GitSignsChangedelete",
	GitSignsDelete = "GitSignsDelete",
	GitSignsTopdelete = "GitSignsTopdelete",
	GitSignsUntracked = "GitSignsUntracked",
}

local diag_signs_icons = {
	DiagnosticSignError = "",
	DiagnosticSignWarn = "",
	DiagnosticSignInfo = "",
	DiagnosticSignHint = "",
	DiagnosticSignOk = "",
}

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", numhl = "DapBreakpoint" })
vim.fn.sign_define("DapBreakpointCondition", { text = "ﳁ", texthl = "DapBreakpoint", numhl = "DapBreakpoint" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpoint", numhl = "DapBreakpoint" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", numhl = "DapLogPoint" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })

local function get_sign_name(cur_sign)
	if cur_sign == nil then
		return nil
	end

	cur_sign = cur_sign[1]

	if cur_sign == nil then
		return nil
	end

	cur_sign = cur_sign.signs

	if cur_sign == nil then
		return nil
	end

	cur_sign = cur_sign[1]

	if cur_sign == nil then
		return nil
	end

	return cur_sign["name"]
end

local function mk_hl(group, sym)
	return table.concat({ "%#", group, "#", sym, "%*" })
end

_G.set_statuscol_breakpoint = function()
	local mousepos = vim.fn.getmousepos()
	require("dap.breakpoints").toggle({}, vim.api.nvim_win_get_buf(mousepos.winid), mousepos.line)
end

local function get_name_from_group(bufnum, lnum, group)
	local cur_sign_tbl = vim.fn.sign_getplaced(bufnum, {
		group = group,
		lnum = lnum,
	})

	return get_sign_name(cur_sign_tbl)
end

local function get_breakpoint_signs(bufexpr)
	if bufexpr then
		return vim.fn.sign_getplaced(bufexpr, { group = "dap_breakpoints" })
	end
	local bufs_with_signs = vim.fn.sign_getplaced()
	local result = {}
	for _, buf_signs in ipairs(bufs_with_signs) do
		buf_signs = vim.fn.sign_getplaced(buf_signs.bufnr, { group = "dap_breakpoints" })[1]
		if #buf_signs.signs > 0 then
			table.insert(result, buf_signs)
		end
	end
	return result
end

_G.get_statuscol_breakpoint = function(bufnr, lnum)
	local signs = get_breakpoint_signs(bufnr)

	for _, v in ipairs(signs[1].signs) do
		if v.lnum == lnum then
			local sign = vim.fn.sign_getdefined(v.name)[1]

			return mk_hl(sign.numhl, string.gsub(sign.text, "%s+", ""))
		end
	end

	return mk_hl("SignColumn", " ")
end

_G.get_statuscol_gitsign = function(bufnr, lnum)
	local cur_sign_nm = get_name_from_group(bufnr, lnum, "gitsigns_vimfn_signs_")

	if cur_sign_nm ~= nil then
		return mk_hl(gitsigns_hl_pool[cur_sign_nm], string.gsub(gitsigns_bar, "%s+", ""))
	end

	return mk_hl("SignColumn", " ")
end

_G.get_statuscol_diag = function(bufnum, lnum)
	local cur_sign_nm = get_name_from_group(bufnum, lnum, "*")

	if cur_sign_nm ~= nil and vim.startswith(cur_sign_nm, "DiagnosticSign") then
		return mk_hl(cur_sign_nm, string.gsub(diag_signs_icons[cur_sign_nm], "%s+", ""))
	end

	return mk_hl("SignColumn", " ")
end

_G.statuscol_gen_space = function()
	return mk_hl("SignColumn", " ")
end

_G.get_statuscol = function(order)
	local str_table = { "%@v:lua.set_statuscol_breakpoint@" }

	local parts = {
		["diagnostics"] = "%{%v:lua.get_statuscol_diag(bufnr(), v:lnum)%}",
		["breakpoints"] = "%{%v:lua.get_statuscol_breakpoint(bufnr(), v:lnum)%}",
		["fold"] = "%C",
		["gitsigns"] = "%{%v:lua.get_statuscol_gitsign(bufnr(), v:lnum)%}",
		["num"] = "%{v:relnum?v:relnum:v:lnum}",
		["sep"] = "%=",
		["space"] = "%{%v:lua.statuscol_gen_space()%}",
		["lastSep"] = "%#StatusColSep#◼%#Normal#",
		["clear"] = "%#Normal# ",
	}

	for _, val in ipairs(order) do
		table.insert(str_table, parts[val])
	end

	table.insert(str_table, "%T")

	return table.concat(str_table)
end

vim.o.signcolumn = "no"

vim.o.statuscolumn = _G.get_statuscol({
	"gitsigns",
	"diagnostics",
	"sep",
	"breakpoints",
	"sep",
	"num",
	"space",
	"lastSep",
	"clear",
})
