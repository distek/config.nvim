local goGroup = vim.api.nvim_create_augroup("Go", { clear = true })

local map = vim.keymap.set

map("n", "<leader>Gfs", ":GoFillStruct<cr>", { desc = "Go: Fill struct" })
map("n", "<leader>Gie", ":GoIfErr<cr>", { desc = "Go: Context-aware if err" })
map("n", "<leader>Gwe", ":GoWrapInError<cr>", { desc = "Go: Context-aware error wrapper" })
map("n", "<leader>Gat", ":GoAddTest<cr>", { desc = "Go: Add test for current function" })

if not vim.g.vscode then
	map("n", "<leader>Gt", require("neotest").run.run, { desc = "Go: Run test under cursor" })
	map("n", "<leader>GT", function()
		require("neotest").run.run(vim.fn.getcwd())
	end, { desc = "Go: Run test project" })
end

vim.api.nvim_create_autocmd("BufWritePost", {
	callback = function()
		-- for _, v in ipairs(vim.api.nvim_list_bufs()) do
		-- 	if vim.bo[v].filetype == "gomod" then
		-- 		vim.notify("Close go.mod dingus")
		-- 		return
		-- 	end
		-- end
		if vim.bo[0].filetype == "go" then
			require("plenary.job")
				:new({
					command = "go",
					args = { "mod", "tidy" },
				})
				:start()
		end
	end,
	group = goGroup,
})

local function getGoBin()
	return vim.fn.systemlist("go env GOBIN")[1]
end

function GoIfErr()
	local byte_offset = vim.fn.wordcount().cursor_bytes

	local goBin = getGoBin()
	if vim.v.shell_error ~= 0 then
		vim.print("Shell err: " .. vim.inspect(goBin))
		return
	end

	local cmd = string.format(goBin .. "/iferr -pos %d", byte_offset)

	local data = vim.fn.systemlist(cmd, vim.fn.bufnr("%"))

	if vim.v.shell_error ~= 0 then
		vim.print("Shell err: " .. vim.inspect(data))
		return
	end

	local pos = vim.fn.getcurpos()[2]
	vim.fn.append(pos, data)

	vim.cmd("silent normal! j=2j")
	vim.fn.setpos(".", pos)
	vim.cmd("silent normal! j")
end

local goTools = {
	gomodifytags = "github.com/fatih/gomodifytags",
	goimports = "golang.org/x/tools/cmd/goimports",
	gopls = "golang.org/x/tools/gopls",
	gotests = "github.com/cweill/gotests/...",
	iferr = "github.com/koron/iferr",
	impl = "github.com/josharian/impl",
	dlv = "github.com/go-delve/delve/cmd/dlv",
	["json-to-struct"] = "github.com/tmc/json-to-struct",
}

function GoInstallBinaries(args)
	local current = 1

	local installUs = goTools

	if args ~= "" then
		installUs = {}
		for v in string.gmatch(args, "%S+") do
			local base = vim.split(v, "/")
			installUs[base[#base]] = v
		end
	end

	local total = 0
	for _ in pairs(installUs) do
		total = total + 1
	end

	for t, v in pairs(installUs) do
		vim.notify(string.format("[%d/%d] Installing %s", current, total, t))

		local err = vim.fn.systemlist("go install " .. v .. "@latest")

		if vim.v.shell_error ~= 0 then
			vim.print("Shell err: " .. vim.inspect(err))
			return
		end

		current = current + 1
	end

	vim.notify(string.format("[%d/%d] Done installing Go tools!", total, total, t))
end

function GoFillStruct()
	Util.codeAction("gopls", "source.fillStruct", false)
end

function GoAddTags(args)
	if args == "" then
		args = "camelcase"
	end
	local byte_offset = vim.fn.wordcount().cursor_bytes

	local goBin = getGoBin()
	if vim.v.shell_error ~= 0 then
		vim.print("Shell err: " .. vim.inspect(goBin))
		return
	end

	local cmd = string.format(
		"%s/gomodifytags -transform %s -add-tags json -offset %d -add-options json=omitempty -file %s",
		goBin,
		args,
		byte_offset,
		vim.fn.bufname("%")
	)

	local data = vim.fn.systemlist(cmd)

	if vim.v.shell_error ~= 0 then
		vim.print("Shell err: " .. vim.inspect(data))
		return
	end

	vim.api.nvim_buf_set_lines(0, 0, -1, true, data)

	local pos = vim.fn.getcurpos()
	vim.fn.setpos(".", pos)
end

local function complete(ArgLead, _, _, candidates)
	return vim.tbl_filter(function(c)
		return c:find("^" .. ArgLead) ~= nil
	end, candidates)
end

vim.api.nvim_create_user_command("GoIfErr", "lua GoIfErr()", {})
vim.api.nvim_create_user_command("GoAddTest", "lua GoAddTest(true)", {})
vim.api.nvim_create_user_command("GoWrapInError", "lua GoWrapInError()", {})
vim.api.nvim_create_user_command("GoFillStruct", "lua GoFillStruct()", {})
vim.api.nvim_create_user_command("GoInstallBinaries", function(opts)
	GoInstallBinaries(opts.args)
end, {
	nargs = "*",
	complete = function(ArgLead, CmdLine, CursorPos)
		local candidates = goTools

		return vim.tbl_filter(function(c)
			return c:find("^" .. ArgLead) ~= nil
		end, candidates)
	end,
})
vim.api.nvim_create_user_command("GoAddTags", function(opts)
	GoAddTags(opts.args)
end, {
	nargs = "*",
	complete = function(ArgLead, CmdLine, CursorPos)
		local candidates = { "snakecase", "camelcase", "lispcase", "pascalcase", "titlecase", "keep" }

		return vim.tbl_filter(function(c)
			return c:find("^" .. ArgLead) ~= nil
		end, candidates)
	end,
})

-- ls.add_snippets("go", {
-- 	s("fpwd", {
-- 		t({
-- 			"err := filepath.WalkDir(dir, func(path string, info os.DirEntry, err error) error {",
-- 			"\t",
-- 		}),
-- 		t({ "if err != nil {", "\t\t" }),
-- 		t({ "return err", "\t" }),
-- 		t({ "}", "\t" }),
-- 		t({ "", "\t" }),
-- 		i(0),

-- 		t({ "", "\t" }),
-- 		t({ "", "\t" }),
-- 		t({ "return nil" }),
-- 		t({ "", "})" }),
-- 	}),
