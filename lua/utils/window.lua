Util.win_focus = function(dir)
    local function getStuff(d)
        if d == "left" then
            return "h", "L", "left", "left"
        elseif d == "down" then
            return "j", "D", "bottom", "below"
        elseif d == "up" then
            return "k", "U", "top", "above"
        else --right
            return "l", "R", "right", "right"
        end
    end

    local vimLetter, tmuxLetter, word, itermWord = getStuff(dir)

    if vim.fn.winnr() == vim.fn.winnr(vimLetter) then
        -- local current = vim.api.nvim_get_current_win()

        -- vim.cmd("wincmd " .. vimLetter)
        if os.getenv("TMUX") ~= nil then
            vim.cmd("silent !tmux-tools focus-pane " .. word)

            return
        end

        -- wezterm if I switch from tmux again for some reason
        -- if os.getenv("TERM_PROGRAM") == "WezTerm" then
        -- 	vim.cmd("silent !wezterm cli activate-pane-direction " .. word)
        -- 	return
        -- end
        --TERM_PROGRAM=iTerm.app
        -- if os.getenv("TERM_PROGRAM") == "iTerm.app" then
        -- 	vim.cmd(
        -- 		"silent !echo 'focus_pane "
        -- 			.. itermWord
        -- 			.. " vim' | /opt/homebrew/bin/socat - UNIX-CONNECT:/tmp/iterm2.sock"
        -- 	)

        -- 	return
        -- end
    else
        vim.cmd("wincmd " .. vimLetter)
    end
end

Util.win_resize = function(dir)
    local n = Util.getNeighbors()

    local edgyWin = require("edgy").get_win()

    if edgyWin ~= nil then
        if dir == "top" then
            edgyWin:resize("height", 2)
        elseif dir == "bottom" then
            edgyWin:resize("height", -2)
        elseif dir == "left" then
            edgyWin:resize("width", -2)
        elseif dir == "right" then
            edgyWin:resize("width", 2)
        end
        return
    end

    -- I wish lua had a switch case
    if dir == "top" then
        -- middle split
        if n.top and n.bottom then
            vim.cmd("res +1")
            goto ret
        end

        -- top split with bottom neighbor
        if not n.top and n.bottom then
            vim.cmd(vim.fn.winnr("j") .. "res +1")
            goto ret
        end

        -- bottom split with top neighbor
        if n.top and not n.bottom then
            vim.cmd(vim.fn.winnr("k") .. "res -1")
            goto ret
        end

        -- only horizontal window, attempt tmux resize
        if not n.top and not n.bottom then
            vim.cmd("silent !tmux resize-pane -U 1")
        end

        goto ret
    end

    if dir == "bottom" then
        -- middle split
        if n.top and n.bottom then
            vim.cmd(vim.fn.winnr("k") .. "res +1")
            vim.cmd("res -1")
            goto ret
        end

        -- top split with bottom neighbor
        if not n.top and n.bottom then
            vim.cmd(vim.fn.winnr("k") .. "res +1")
            goto ret
        end

        -- bottom split with top neighbor
        if n.top and not n.bottom then
            vim.cmd(vim.fn.winnr("j") .. "res -1")
            goto ret
        end

        -- only horizontal window, attempt tmux resize
        if not n.top and not n.bottom then
            vim.cmd("silent !tmux resize-pane -D 1")
        end

        goto ret
    end

    if dir == "left" then
        if not n.left and n.right or n.left and n.right then
            vim.cmd("vert res -1")
            goto ret
        end

        if not n.right and n.left then
            vim.cmd("vert res +1")
            goto ret
        end

        if n.right then
            vim.cmd("vert res +1")
            goto ret
        end

        vim.cmd("silent !tmux resize-pane -L 1")

        goto ret
    end

    if dir == "right" then
        -- middle
        if n.left and n.right then
            vim.cmd("vert res +1")
            goto ret
        end

        -- left
        if not n.left and n.right then
            vim.cmd("vert res +1")
            goto ret
        end

        -- right
        if n.left then
            vim.cmd("vert res -1")
            goto ret
        end

        vim.cmd("silent !tmux resize-pane -R 1")
    end

    ::ret::
end

Util.openInWindow = function(path)
    if path == "" then
        return
    end

    local winID = require("window-picker").pick_window({
        hint = "statusline-winbar",
        picker_config = {
            -- whether should select window by clicking left mouse button on it
            handle_mouse_click = false,
            statusline_winbar_picker = {
                -- You can change the display string in status bar.
                -- It supports '%' printf style. Such as `return char .. ': %f'` to display
                -- buffer file path. See :h 'stl' for details.
                selection_display = function(char, windowid)
                    return "%=" .. char .. "%="
                end,

                -- whether you want to use winbar instead of the statusline
                -- "always" means to always use winbar,
                -- "never" means to never use winbar
                -- "smart" means to use winbar if cmdheight=0 and statusline if cmdheight > 0
                use_winbar = "never", -- "always" | "never" | "smart"
            },
        },
        -- whether to show 'Pick window:' prompt
        show_prompt = true,

        -- prompt message to show to get the user input
        prompt_message = "Pick window: ",
        filter_rules = {
            -- when there is only one window available to pick from, use that window
            -- without prompting the user to select
            autoselect_one = true,

            -- whether you want to include the window you are currently on to window
            -- selection or not
            include_current_win = true,

            -- whether to include windows marked as unfocusable
            include_unfocusable_windows = false,

            -- filter using buffer options
            bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { "toggleterm", "Outline", "neotest-summary" },

                -- if the file type is one of following, the window will be ignored
                buftype = { "terminal" },
            },
        },
    })

    if winID == nil then
        return
    end

    vim.api.nvim_set_current_win(winID)

    vim.cmd("edit " .. path:gsub("%s", "\\ "))
end
