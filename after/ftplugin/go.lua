vim.api.nvim_create_augroup("Go", { clear = true })

local opts = { noremap = true, silent = true }
local map = function(mode, keys, command)
    vim.api.nvim_set_keymap(mode, keys, command, opts)
end

map("n", "<leader>Gfs", ":GoFillStruct<cr>")
map("n", "<leader>Gie", ":GoIfErr<cr>")
map("n", "<leader>Gat", ":GoAddTest<cr>")

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*go" },
    callback = function()
        vim.cmd("GoImport")
    end,
    group = "Go",
})

-- Add test for function under cursor
-- Args:
--     open: bool - opens test file after function creation
-- function GoAddTest(open)
--     if vim.fn.executable("gotests") == 0 then
--         vim.notify("GoAddTest: gotests not in path or not installed", vim.log.levels.ERROR)
--         return
--     end

--     local bufNumber = vim.api.nvim_get_current_buf()

--     local bufPath = vim.api.nvim_buf_get_name(bufNumber)

--     local ts_utils = require("nvim-treesitter.ts_utils")

--     local node = ts_utils.get_node_at_cursor()
--     if not node then
--         return
--     end

--     local currentNode = node

--     while currentNode do
--         if currentNode:type() == "function_declaration" then
--             break
--         end
--         currentNode = currentNode:parent()
--     end

--     if not currentNode then
--         vim.notify("GoAddTest: Could not find parent", vim.log.levels.ERROR)
--         return
--     end

--     local funcName = vim.treesitter.query.get_node_text(currentNode:child(1), 0)

--     if not funcName then
--         vim.notify("GoAddTest: No function under cursor", vim.log.levels.ERROR)
--         return
--     end

--     local subRoot, _ = bufPath:gsub(vim.lsp.buf.list_workspace_folders()[1] .. "/", "")

--     local pathSubGo = subRoot:gsub(".go$", "")

--     os.execute(
--         'gotests -only "^' .. funcName .. '$" -w ' .. pathSubGo .. "_test.go " .. pathSubGo .. ".go "-- what I have to do
--     )

--     if open then
--         vim.cmd("edit " .. pathSubGo .. "_test.go")
--     end
-- end

-- vim.api.nvim_create_user_command("GoAddTest", "lua GoAddTest(true)", {})
