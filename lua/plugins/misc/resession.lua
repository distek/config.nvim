return {
	"stevearc/resession.nvim",
	config = function()
		require("resession").setup({
			-- Options for automatically saving sessions on a timer
			autosave = {
				enabled = true,
				-- How often to save (in seconds)
				interval = 60,
				-- Notify when autosaved
				notify = true,
			},
			-- Save and restore these options
			options = {
				"binary",
				"bufhidden",
				"buflisted",
				"cmdheight",
				"diff",
				"filetype",
				"modifiable",
				"previewwindow",
				"readonly",
				"scrollbind",
				"winfixheight",
				"winfixwidth",
			},
			-- Custom logic for determining if the buffer should be included
			-- override default filter
			buf_filter = function(bufnr)
				local buftype = vim.bo[bufnr].buftype
				if buftype == "help" then
					return true
				end
				if buftype ~= "" and buftype ~= "acwrite" then
					return false
				end
				if vim.api.nvim_buf_get_name(bufnr) == "" then
					return false
				end

				-- this is required, since the default filter skips nobuflisted buffers
				return true
			end,
			-- Custom logic for determining if a buffer should be included in a tab-scoped session
			tab_buf_filter = function(tabpage, bufnr)
				return true
			end,
			-- The name of the directory to store sessions in
			dir = "resession",
			-- Show more detail about the sessions when selecting one to load.
			-- Disable if it causes lag.
			load_detail = true,
			-- List order ["modification_time", "creation_time", "filename"]
			load_order = "modification_time",
			-- Configuration for extensions
			extensions = { scope = {} }, -- add scope.nvim extension
		})

		vim.api.nvim_create_autocmd("VimLeavePre", {
			callback = function()
				-- Always save a special session named "last"
				require("resession").save("last")
			end,
		})

		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				-- Only load the session if nvim was started with no args
				if vim.fn.argc(-1) == 0 then
					-- Save these to a different directory, so our manual sessions don't get polluted
					require("resession").load(
						vim.fn.getcwd(),
						{ dir = "dirsession", silence_errors = true }
					)
				end
			end,
		})
		vim.api.nvim_create_autocmd("VimLeavePre", {
			callback = function()
				require("resession").save(
					vim.fn.getcwd(),
					{ dir = "dirsession", notify = false }
				)
			end,
		})
	end,
}
