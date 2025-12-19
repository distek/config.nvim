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

local function getErrFunc()
	local vts = vim.treesitter

	local node = vts.get_node({ bufnr = 0 })
	if node == nil then
		return
	end

	while node:type() ~= "short_var_declaration" do
		if node:prev_sibling() == nil then
			node = node:parent()
			if node == nil then
				return
			end
		else
			node = node:prev_sibling()
		end
	end

	if node == nil then
		return
	end

	local theNode = nil

	for c in node:iter_children() do
		for c1 in c:iter_children() do
			if c1:type() == "call_expression" then
				theNode = c1
			end
		end
	end

	if theNode == nil then
		return
	end

	for c in theNode:iter_children() do
		if c:type() == "selector_expression" or c:type() == "identifier" then
			return vts.get_node_text(c, 0)
		end
	end
end

vim.api.nvim_create_autocmd("BufWritePost", {
	callback = function()
		for _, v in ipairs(vim.api.nvim_list_bufs()) do
			if vim.bo[v].filetype == "gomod" then
				vim.notify("Close go.mod dingus")
				return
			end
		end
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

local function getTSNodeUp(nodeType)
	local ts_utils = require("nvim-treesitter.ts_utils")

	local node = ts_utils.get_node_at_cursor()
	if not node then
		return nil
	end

	local currentNode = node

	while currentNode do
		if currentNode:type() == nodeType then
			break
		end
		currentNode = currentNode:parent()
	end

	return currentNode
end

local function getTSNodeDown(parent, nodeType)
	local currentParentChild = 0

	local currentNode = parent:child(0)

	while true do
		if currentNode:type() == nodeType then
			break
		end

		currentNode = currentNode:child()

		if currentNode == nil then
			currentParentChild = currentParentChild + 1

			currentNode = parent:child(currentParentChild)

			if currentNode == nil then
				return nil
			end
		end
	end

	return currentNode
end

-- Add test for function under cursor
-- Args:
--     open: bool - opens test file after function creation
function GoAddTest(open)
	if vim.fn.executable("gotests") == 0 then
		vim.notify("GoAddTest: gotests not in path or not installed", vim.log.levels.ERROR)
		return
	end

	local bufNumber = vim.api.nvim_get_current_buf()

	local bufPath = vim.api.nvim_buf_get_name(bufNumber)

	local node = getTSNodeUp("function_declaration")

	if node == nil then
		vim.notify("GoAddTest: Could not find parent", vim.log.levels.ERROR)
		return
	end

	local funcName = vim.treesitter.get_node_text(node:child(1), 0)

	if not funcName then
		vim.notify("GoAddTest: No function under cursor", vim.log.levels.ERROR)
		return
	end

	local subRoot, _ = bufPath:gsub(vim.lsp.buf.list_workspace_folders()[1] .. "/", "")

	local pathSubGo = subRoot:gsub(".go$", "")

	os.execute(
		'gotests -only "^' .. funcName .. '$" -w ' .. pathSubGo .. "_test.go " .. pathSubGo .. ".go " -- what I have to do
	)

	if open then
		vim.cmd("edit " .. pathSubGo .. "_test.go")
	end
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

function GoInstallBinaries()
	local current = 1

	local total = 0

	for _ in pairs(goTools) do
		total = total + 1
	end

	for t, v in pairs(goTools) do
		vim.notify(string.format("[%d/%d] Installing %s", current, total, t))

		local err = vim.fn.systemlist("go install " .. v .. "@latest")

		if vim.v.shell_error ~= 0 then
			vim.print("Shell err: " .. vim.inspect(err))
			return
		end

		current = current + 1
	end
end

function GoFillStruct()
	Util.codeAction("gopls", "source.fillStruct", false)
end

function GoAddTags()
	local byte_offset = vim.fn.wordcount().cursor_bytes

	local goBin = getGoBin()
	if vim.v.shell_error ~= 0 then
		vim.print("Shell err: " .. vim.inspect(goBin))
		return
	end

	local node = getTSNodeUp("type_spec")

	if node == nil then
		vim.notify("GoAddTags: Could not find struct node")
		return
	end

	local structName = vim.treesitter.get_node_text(node:child(0), 0)
	if structName == nil then
		vim.notify("GoAddTags: Could not determine struct name")
		return
	end

	local cmd = string.format(
		"%s/gomodifytags -add-tags json -struct %s -add-options json=omitempty -file %s",
		goBin,
		structName,
		vim.fn.bufname("%")
	)

	local data = vim.fn.systemlist(cmd)

	if vim.v.shell_error ~= 0 then
		vim.print("Shell err: " .. vim.inspect(data))
		return
	end

	local pos = vim.fn.getcurpos()
	vim.api.nvim_buf_set_lines(0, 0, -1, true, data)

	vim.fn.setpos(".", pos)
end

function GoWrapInError()
	local curPosNode = vim.treesitter.get_node({ bufnr = 0 })
	local curPosNodeText = ""
	if curPosNode ~= nil then
		local parentNode = curPosNode:parent()
		if parentNode == nil then
			return
		end

		while true do
			if parentNode:type() ~= "expression_list" then
				curPosNode = parentNode
				parentNode = parentNode:parent()

				if parentNode == nil then
					return
				end
			else
				break
			end
		end

		curPosNodeText = vim.treesitter.get_node_text(curPosNode, 0)
	else
		return
	end

	-- Package
	local sourceNode = getTSNodeUp("source_file")

	if sourceNode == nil then
		vim.notify("GoWrapErr: package: Could not find package: sourceNode == nil", vim.log.levels.ERROR)
		return
	end

	local packageNode = getTSNodeDown(sourceNode, "package_clause")

	if packageNode == nil then
		vim.notify("GoWrapErr: package: Could not find package: packageNode == nil", vim.log.levels.ERROR)
		return
	end

	local packageName = vim.treesitter.get_node_text(packageNode:child(1), 0)

	if not packageName then
		vim.notify("GoWrapErr: package: Could not determine package?", vim.log.levels.ERROR)
		return
	end

	-- Func
	local funcNode = getTSNodeUp("function_declaration")

	if funcNode == nil then
		vim.notify("GoWrapErr: func: Could not find parent", vim.log.levels.ERROR)
		return
	end

	local funcName = vim.treesitter.get_node_text(funcNode:child(1), 0)

	if not funcName then
		vim.notify("GoWrapErr: func: No function near cursor?", vim.log.levels.ERROR)
		return
	end

	-- last method assigning err
	local lastMethod = getErrFunc()

	if not lastMethod then
		vim.notify("GoWrapErr: lastMethod: could not find last method", vim.log.levels.ERROR)
		return
	end

	vim.ui.input({ prompt = 'Error string (default: "err"): ', default = nil }, function(input)
		if input == nil then
			return
		end

		local wrapped = string.format(
			'fmt.Errorf("%s: %s: %s: %s: %%s", %s)',
			packageName,
			funcName,
			lastMethod,
			input,
			curPosNodeText
		)

		local _, sCol, _, eCol = curPosNode:range()

		local line = vim.api.nvim_get_current_line()
		vim.api.nvim_set_current_line(line:sub(0, sCol) .. wrapped .. line:sub(eCol + 1))
	end)

	-- packageName: funcName: lastMethod: <user input>: err
end

vim.api.nvim_create_user_command("GoAddTest", "lua GoAddTest(true)", {})
vim.api.nvim_create_user_command("GoIfErr", "lua GoIfErr()", {})
vim.api.nvim_create_user_command("GoWrapInError", "lua GoWrapInError()", {})
vim.api.nvim_create_user_command("GoFillStruct", "lua GoFillStruct()", {})
vim.api.nvim_create_user_command("GoInstallBinaries", "lua GoInstallBinaries()", {})
vim.api.nvim_create_user_command("GoAddTags", "lua GoAddTags()", {})

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
