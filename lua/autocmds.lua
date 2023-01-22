-- Return to previous line in fileauto
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = { "*" },
    callback = function()
        Util.line_return()
    end,
})

-- -- Automatically format buffers
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*" },
    callback = function()
        -- vim.cmd("mkview")
        vim.lsp.buf.format({
            async = false,
        })
    end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*" },
    callback = function()
        vim.cmd("normal! zv")
    end,
})

-- LSP - documentHighlight
-- highlight - normal
vim.api.nvim_create_autocmd("CursorHold", {
    pattern = { "<buffer>" },
    callback = function()
        local clients = vim.lsp.get_active_clients()

        if not next(clients) then
            return
        end

        if clients[1].server_capabilities.documentHighlightProvider then
            vim.lsp.buf.document_highlight()
        end
    end,
})

-- highlight - insert
vim.api.nvim_create_autocmd("CursorHoldI", {
    pattern = { "<buffer>" },
    callback = function()
        local clients = vim.lsp.get_active_clients()

        if not next(clients) then
            return
        end

        if clients[1].server_capabilities.documentHighlightProvider then
            vim.lsp.buf.document_highlight()
        end
    end,
})

-- highlight clear on move
vim.api.nvim_create_autocmd("CursorMoved", {
    pattern = { "<buffer>" },
    callback = function()
        vim.lsp.buf.clear_references()
    end,
})

-- Deal with quickfix
-- set nobuflisted and close if last window
vim.api.nvim_create_augroup("qf", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "qf" },
    callback = function()
        vim.o.buflisted = false
    end,
    group = "qf",
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "NvimTree" },
    callback = function()
        vim.wo.statuscolumn = ""
    end,
})


vim.api.nvim_create_autocmd("WinEnter", {
    pattern = { "*" },
    callback = function()
        if vim.fn.winnr("$") == 1 and vim.bo.buftype == "quickfix" then
            vim.cmd([[q]])
        end
    end,
    group = "qf",
})

-- Terminal
vim.api.nvim_create_augroup("Terminal", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "term://*" },
    callback = function()
        vim.cmd([[startinsert]])
    end,
    group = "Terminal",
})

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = { "*" },
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.wrap = true
        vim.opt_local.list = false
        vim.opt_local.signcolumn = "no"
        vim.opt_local.statuscolumn = ""
    end,
    group = "Terminal",
})

vim.api.nvim_create_augroup("markdown", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.md" },
    callback = function()
        vim.cmd([[setlocal spell]])
    end,
    group = "markdown",
})

-- Remove cursorline in insert mode
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
    pattern = { "*" },
    callback = function()
        vim.o.cursorline = true
    end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
    pattern = { "*" },
    callback = function()
        vim.o.cursorline = false
    end,
})
