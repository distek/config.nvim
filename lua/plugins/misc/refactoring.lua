return {
	"ThePrimeagen/refactoring.nvim",
	event = "VeryLazy",
    config = function()
        require('refactoring').setup({
            prompt_func_return_type = {
                go = true,
                cpp = true,
                c = true,
                h = true,
                hpp = true,
                cxx = true,
            },
            prompt_func_param_type = {
                go = true,
                cpp = true,
                c = true,
                h = true,
                hpp = true,
                cxx = true,
            },
        })
    end,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}
