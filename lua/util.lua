function len(t)
    local count = 0
    for _ in pairs(t) do
        count = count + 1
    end
    return count
end

Util = {}

-- Returns to previous position in file
Util.line_return = function()
    local line = vim.fn.line

    if line("'\"") > 0 and line("'\"") <= line("$") then
        vim.cmd("normal! g`\"zvzz'")
    end
end

-- Skips over quickfix buf when tabbing through buffers
-- Reason: QF appears to overwrite the <Tab> mappings
Util.skipUnwantedBuffers = function(dir)
    -- Util.bufFocus(dir)
    if dir == "next" then
        -- require('tabline').buffer_next()
        require("bufferline").cycle(1)
    else
        -- require('tabline').buffer_previous()
        require("bufferline").cycle(-1)
    end

    local buftype = vim.api.nvim_buf_get_option(0, "buftype")

    if buftype == "quickfix" or buftype == "terminal" then
        if buftype == "terminal" then
            -- if the terminal is not open elsewhere
            if len(vim.fn.win_findbuf(vim.fn.bufnr("%"))) == 1 then
                return
            end

            vim.cmd([[stopinsert]])

            return
        end

        Util.skipUnwantedBuffers(dir)
    end
end

Util.dapStart = function()
    local dapui = require("dapui")
    dapui.open({})
end

Util.dapStop = function()
    local dap = require("dap")
    local dapui = require("dapui")

    if dap.session() then
        dap.disconnect()
    end

    dap.close()
    dapui.close({})
end

local function hexToRgb(hex_str)
    if hex_str == "none" then
        return
    end

    local hex = "[abcdef0-9][abcdef0-9]"
    local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
    hex_str = string.lower(hex_str)

    assert(string.find(hex_str, pat) ~= nil, "hex_to_rgb: invalid hex_str: " .. tostring(hex_str))

    local r, g, b = string.match(hex_str, pat)
    return { tonumber(r, 16), tonumber(g, 16), tonumber(b, 16) }
end

local function blend(fg, bg, alpha)
    bg = hexToRgb(bg)
    fg = hexToRgb(fg)

    local blendChannel = function(i)
        local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
        return math.floor(math.min(math.max(0, ret), 255) + 0.5)
    end

    return string.format("#%02X%02X%02X", blendChannel(1), blendChannel(2), blendChannel(3))
end

Util.darken = function(hex, amount)
    return blend(hex, "#000000", math.abs(amount))
end

Util.lighten = function(hex, amount)
    return blend(hex, "#ffffff", math.abs(amount))
end

Util.getColor = function(group, attr)
    return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group)), attr)
end

Util.inspect = function(vars, ...)
    print(vim.inspect(vars, ...))
end

Util.win_focus_bottom = function()
    local currentWin = vim.fn.winnr()

    if currentWin == vim.fn.winnr("j") then
        vim.cmd("silent !tmux select-pane -D")
        return
    end

    vim.cmd("wincmd j")
end

Util.win_focus_top = function()
    local currentWin = vim.fn.winnr()

    if currentWin == vim.fn.winnr("k") then
        vim.cmd("silent !tmux select-pane -U")
        return
    end

    vim.cmd("wincmd k")
end

Util.win_focus_left = function()
    local currentWin = vim.fn.winnr()

    if currentWin == vim.fn.winnr("h") then
        vim.cmd("silent !tmux select-pane -L")
        return
    end

    vim.cmd("wincmd h")
end

Util.win_focus_right = function()
    local currentWin = vim.fn.winnr()

    if currentWin ~= vim.fn.winnr("l") then
        vim.cmd("wincmd l")
        return
    end

    vim.cmd("silent !tmux select-pane -R")
end

local function getNeighbors()
    local ret = {
        top = false,
        bottom = false,
        left = false,
        right = false,
    }

    if len(vim.api.nvim_list_wins()) == 1 then
        return ret
    end

    local currentWin = vim.fn.winnr()

    if currentWin ~= vim.fn.winnr("k") then
        ret.top = true
    end

    if currentWin ~= vim.fn.winnr("j") then
        ret.bottom = true
    end

    if currentWin ~= vim.fn.winnr("h") then
        ret.left = true
    end

    if currentWin ~= vim.fn.winnr("l") then
        ret.right = true
    end

    return ret
end

Util.win_resize = function(dir)
    local n = getNeighbors()

    -- I wish lua had a switch case
    if dir == "top" then
        -- middle split
        if n.top and n.bottom then
            vim.cmd("res +1")
            return
        end

        -- top split with bottom neighbor
        if not n.top and n.bottom then
            vim.cmd(vim.fn.winnr("j") .. "res +1")
            return
        end

        -- bottom split with top neighbor
        if n.top and not n.bottom then
            vim.cmd(vim.fn.winnr("k") .. "res -1")
            return
        end

        -- only horizontal window, attempt tmux resize
        if not n.top and not n.bottom then
            vim.cmd("silent !tmux resize-pane -U 1")
        end
    end

    if dir == "bottom" then
        -- middle split
        if n.top and n.bottom then
            vim.cmd(vim.fn.winnr("k") .. "res +1")
            vim.cmd("res -1")
            return
        end

        -- top split with bottom neighbor
        if not n.top and n.bottom then
            vim.cmd(vim.fn.winnr("k") .. "res +1")
            return
        end

        -- bottom split with top neighbor
        if n.top and not n.bottom then
            vim.cmd(vim.fn.winnr("j") .. "res -1")
            return
        end

        -- only horizontal window, attempt tmux resize
        if not n.top and not n.bottom then
            vim.cmd("silent !tmux resize-pane -D 1")
        end
    end

    if dir == "left" then
        if not n.left and n.right or n.left and n.right then
            vim.cmd("vert res -1")
            return
        end

        if not n.right and n.left then
            vim.cmd("vert res +1")
            return
        end

        if n.right then
            vim.cmd("vert res +1")
            return
        end

        vim.cmd("silent !tmux resize-pane -L 1")
    end

    if dir == "right" then
        -- middle
        if n.left and n.right then
            vim.cmd("vert res +1")
            return
        end

        -- left
        if not n.left and n.right then
            vim.cmd("vert res +1")
            return
        end

        -- right
        if n.left then
            vim.cmd("vert res -1")
            return
        end

        vim.cmd("silent !tmux resize-pane -R 1")
    end
end

function Float(floatWidthDivisor, floatHeightDivisor)
    -- Allow it to fail if the window can't be floated
    if len(vim.api.nvim_list_wins()) < 2 then
        print("Float() can only be used if there is more than one window")
        return
    end

    local curWin = vim.api.nvim_get_current_win()
    local ui = vim.api.nvim_list_uis()[1]

    -- Allow the divisor to be set elsewhere
    local heightDivisor, widthDivisor = 2, 2
    if floatWidthDivisor then
        widthDivisor = floatWidthDivisor
    end
    if floatHeightDivisor then
        heightDivisor = floatHeightDivisor
    end

    local width, height = math.floor(ui.width / widthDivisor), math.floor(ui.height / heightDivisor)
    local quadBufHeight = vim.api.nvim_buf_line_count(vim.api.nvim_get_current_buf()) * 4

    -- Ensure the window is not ridiculously large for the content
    if quadBufHeight < height then
        height = quadBufHeight
    end

    local opts = {
        relative = "editor",
        width = width,
        height = height,
        col = math.floor(ui.width / 2) - math.floor(width / 2),
        row = math.floor(ui.height / 2) - math.floor(height / 2),
        anchor = "NW",
        style = "minimal",
        border = "shadow",
    }
    -- Make it purtier
    vim.cmd("highlight FloatWinCustom guibg=" .. Util.lighten(Util.getColor("Normal", "bg#"), 0.95))
    vim.api.nvim_win_set_option(curWin, "winhighlight", "Normal:FloatWinCustom")

    vim.api.nvim_win_set_config(curWin, opts)
    return curWin
end

Util.printAllWindowBuffers = function()
    for _, v in ipairs(vim.api.nvim_list_wins()) do
        local name = vim.fn.bufname(vim.api.nvim_win_get_buf(v))
        if name then
            print(name)
        else
            print("unnamed")
        end
    end
end

Util.printAllWindowConfigs = function()
    for _, v in ipairs(vim.api.nvim_list_wins()) do
        Util.inspect(vim.api.nvim_win_get_config(v))
    end
end

-- stole from here:
-- https://github.com/propet/toggle-fullscreen.nvim
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

Util.compVsWinCount = function()
    local winCount = 0
    local compCount = 0

    for _, v in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_config(v).relative == "" then
            local ft = vim.api.nvim_win_call(v, function()
                return vim.bo.filetype
            end)

            if ft == "NvimTree" or ft == "toggleterm" or ft == "Outline" then
                compCount = compCount + 1
            end
            winCount = winCount + 1
        end
    end
    return compCount, winCount
end

Util.findNvimTree = function()
    for _, v in ipairs(vim.api.nvim_list_wins()) do
        local name = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(v))

        if vim.api.nvim_win_get_config(v).relative == "" then
            if string.find(name, "NvimTree_", 1, true) then
                return true
            end
        end
    end

    return false
end

Util.ifNameExists = function(n)
    for _, v in ipairs(vim.api.nvim_list_wins()) do
        local name = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(v))
        if string.find(name, n, 1, true) then
            return true, v
        end
    end
    return false, nil
end
