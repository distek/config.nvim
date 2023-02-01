T = require("nvim-terminal")

-- initial tab setup
TF.Term[vim.api.nvim_get_current_tabpage()] = T.NewTerminalInstance({
    pos = "botright",
    split = "sp",
    height = 15,
})

vim.api.nvim_create_autocmd({ "TabNewEntered" }, {
    pattern = "*",
    callback = function(ev)
        if TF.Term[vim.api.nvim_get_current_tabpage()] == nil then
            TF.Term[vim.api.nvim_get_current_tabpage()] = T.NewTerminalInstance({
                pos = "botright",
                split = "sp",
                height = 15,
            })
        end
    end
})

vim.api.nvim_create_autocmd("WinResized", {
    pattern = "*",
    callback = function()
        TF.Term[vim.api.nvim_get_current_tabpage()].window:update_size()
    end,
})

function TermNew()
    local nvt = require("nvim-tree.view").is_visible()
    if nvt then
        require("nvim-tree.api").tree.close()
    end

    TF.NewTerm()

    if nvt then
        require("nvim-tree.api").tree.open()
        vim.cmd("wincmd p")
    end
end

function TermOpen()
    local nvt = require("nvim-tree.view").is_visible()
    if nvt then
        require("nvim-tree.api").tree.close()
    end

    TF.Open()

    if nvt then
        require("nvim-tree.api").tree.open()
        vim.cmd("wincmd p")
    end
end

function TermToggle()
    local nvt = require("nvim-tree.view").is_visible()
    if nvt then
        require("nvim-tree.api").tree.close()
    end

    TF.Toggle()

    if nvt then
        require("nvim-tree.api").tree.open()
        vim.cmd("wincmd p")
    end
end

function TermPick()
    TF.PickTerm(function()
        local nvt = require("nvim-tree.view").is_visible()
        if nvt then
            require("nvim-tree.api").tree.close()
        end
    end, function()
        local nvt = require("nvim-tree.view").is_visible()
        if nvt then
            require("nvim-tree.api").tree.open()
            vim.cmd("wincmd p")
        end
    end)
end
