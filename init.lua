require("plugins")
require("util")
require("themes")
require("statuscolumn")
require("terminal")
require("globals")
require("autocmds")
require("mappings")

if vim.g.neovide then
    require("neovide-settings")
end
