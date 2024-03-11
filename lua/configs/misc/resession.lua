local function bufFilter(bufnr)
	local buftype = vim.bo[bufnr].filetype

	local compFts = {
		"neo-tree",
		"toggleterm",
		"Outline",
		"Trouble",
		"qf",
		"help",
		"fnote",
	}

	for _, v in ipairs(compFts) do
		if buftype == v then
			return false
		end
	end

	if vim.api.nvim_buf_get_name(bufnr) == "" then
		return false
	end

	-- this is required, since the default filter skips nobuflisted buffers
	return true
end

local function tabBufFilter(tabnr, bufnr)
	return bufFilter(bufnr)
end

return function()
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
		buf_filter = bufFilter,
		-- Custom logic for determining if a buffer should be included in a tab-scoped session
		tab_buf_filter = tabBufFilter,
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
			if os.getenv("DOPAGE") ~= "1" then
				require("resession").save("last")
			end
		end,
	})

	vim.api.nvim_create_autocmd("VimEnter", {
		callback = function()
			-- Only load the session if nvim was started with no args
			if vim.fn.argc(-1) == 0 and os.getenv("DOPAGE") ~= "1" then
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
end
