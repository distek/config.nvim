Themes = {}

PanelNS = vim.api.nvim_create_namespace("custom")

Themes["tokyodark"] = function()
    local function gammaSet()
        local hour = tonumber(os.date("%H"))

        if hour < 7 or hour > 17 then
            return "0.9"
        elseif hour > 7 or hour < 12 then
            return "1.0"
        elseif hour > 12 or hour < 17 then
            return "1.1"
        end
    end

    vim.g.tokyodark_transparent_background = false
    vim.g.tokyodark_enable_italic_comment = true
    vim.g.tokyodark_enable_italic = true
    vim.g.tokyodark_color_gamma = gammaSet() -- I wish everyone did this
    vim.cmd("colorscheme tokyodark")
end

Themes["ayu"] = function()
    require("ayu").setup({
        mirage = false,
        overrides = {},
    })
    require("ayu").colorscheme()

    local colors = require("ayu.colors")

    vim.api.nvim_set_hl(PanelNS, "Normal", { bg = Util.lighten(colors.panel_bg, 0.96) })
    vim.api.nvim_set_hl(PanelNS, "CursorLine", { bg = Util.lighten(colors.panel_bg, 0.97) })
end

Themes.tokyodark()
-- Themes.ayu()
