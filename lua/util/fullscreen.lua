Util.fullscreen = {
    win = 0,
    toggle = false,
    previousHeight = 0,
    previousWidth = 0,
    leftPanel = false,
    rightPanel = false,
    bottomPanel = false,
}

Util.fullscreen.leftPanelIsOpen = function()
    return require("nvim-tree.view").is_visible()
end
Util.fullscreen.handleLeft = function(open)
    if open then
        require("nvim-tree.api").tree.open()
        return
    end
    require("nvim-tree.api").tree.close()
end

Util.fullscreen.bottomPanelIsOpen = function()
    return TF.Term.window:is_valid()
end
Util.fullscreen.handleBottom = function(open)
    if open then
        TF.Toggle()
        return
    end
    TF.Term.window:close()
end

Util.fullscreen.rightPanelIsOpen = function()
    return false
end
Util.fullscreen.handleRight = function(open)
end

function Util.toggleFullscreen()
    Util.fullscreen.win = vim.api.nvim_get_current_win()

    if not Util.fullscreen.toggle then
        Util.fullscreen.previousHeight = vim.api.nvim_win_get_height(Util.fullscreen.win)
        Util.fullscreen.previousWidth = vim.api.nvim_win_get_width(Util.fullscreen.win)

        Util.fullscreen.leftPanel = Util.fullscreen.leftPanelIsOpen()
        Util.fullscreen.rightPanel = Util.fullscreen.rightPanelIsOpen()
        Util.fullscreen.bottomPanel = Util.fullscreen.bottomPanelIsOpen()
        Util.fullscreen.handleLeft(false)
        Util.fullscreen.handleRight(false)
        Util.fullscreen.handleBottom(false)


        vim.api.nvim_command([[execute "normal! \<C-w>|"]])
        vim.api.nvim_command([[execute "normal! \<C-w>_"]])
    else
        -- Back to previous size
        vim.api.nvim_win_set_height(Util.fullscreen.win, Util.fullscreen.previousHeight)
        vim.api.nvim_win_set_width(Util.fullscreen.win, Util.fullscreen.previousWidth)

        Util.fullscreen.handleLeft(Util.fullscreen.leftPanel)
        Util.fullscreen.handleRight(Util.fullscreen.rightPanel)
        Util.fullscreen.handleBottom(Util.fullscreen.bottomPanel)
    end

    -- toggle
    Util.fullscreen.toggle = not Util.fullscreen.toggle

    vim.cmd("resize")
end
