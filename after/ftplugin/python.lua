-- vim.o.runtimepath = vim.o.runtimepath .. "," .. vim.fn.stdpath("data") .. "/site/pack/packer/opt/nvim-dap-python"

require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
