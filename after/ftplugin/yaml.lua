vim.opt_local.expandtab = true -- Use spaces instead of tabs
vim.opt_local.shiftwidth = 2 -- Size of an indent
vim.opt_local.softtabstop = 2 -- Number of spaces tabs count for
vim.opt_local.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for

-- Optional: Prevent '#' from resetting indentation to the start of the line
vim.opt_local.indentkeys:remove("0#")
