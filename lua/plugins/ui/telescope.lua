return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-telescope/telescope-dap.nvim",
	},
	config = function()
		TelescopeLayoutGen = function(name)
			local Layout = require("telescope.pickers.layout")

			local function create_window(enter, width, height, row, col, title)
				local bufnr = vim.api.nvim_create_buf(false, true)
				local winid = vim.api.nvim_open_win(bufnr, enter, {
					style = "minimal",
					relative = "editor",
					width = width,
					height = height,
					row = row,
					col = col,
					border = "single",
					title = title,
				})

				-- vim.wo[winid].winhighlight = "Normal:NormalFloat"

				return Layout.Window({
					bufnr = bufnr,
					winid = winid,
				})
			end

			local function destory_window(window)
				if window then
					if vim.api.nvim_win_is_valid(window.winid) then
						vim.api.nvim_win_close(window.winid, true)
					end
					if vim.api.nvim_buf_is_valid(window.bufnr) then
						vim.api.nvim_buf_delete(window.bufnr, { force = true })
					end
				end
			end

			-- default {{{
			local function defaultMount(self)
				local line_count = vim.o.lines - vim.o.cmdheight
				if vim.o.laststatus ~= 0 then
					line_count = line_count - 1
				end

				local width = vim.o.columns
				local height = line_count - 15 - 2

				local topPad = 7

				local paneWidth = math.floor((width * 0.70) / 2)

				self.results = create_window(
					false,
					paneWidth - 1, -- width
					height, -- height
					topPad, -- row
					math.floor(vim.o.columns * 0.15), -- col
					"Results"
				)

				self.preview = create_window(
					false,
					paneWidth - 1,
					height,
					topPad,
					math.floor(vim.o.columns * 0.15 + paneWidth) + 1,
					"Preview"
				)
				self.prompt = create_window(
					true,
					paneWidth * 2,
					1,
					height + topPad + 2,
					math.floor(vim.o.columns * 0.15),
					"Prompt"
				)
			end

			local function defaultUnmount(self)
				destory_window(self.results)
				destory_window(self.preview)
				destory_window(self.prompt)
			end
			-- }}}

			-- select {{{
			local function selectMount(self)
				local line_count = vim.o.lines - vim.o.cmdheight
				if vim.o.laststatus ~= 0 then
					line_count = line_count - 1
				end

				local width = vim.o.columns
				local height = 10

				local topPad = 7

				local paneWidth = math.floor(width * 0.50)

				self.results = create_window(
					false,
					paneWidth, -- width
					height, -- height
					topPad, -- row
					math.floor(vim.o.columns * 0.25), -- col
					"Results"
				)

				self.prompt =
					create_window(true, paneWidth, 1, height + topPad + 2, math.floor(vim.o.columns * 0.25), "Prompt")
			end
			local function selectUnmount(self)
				destory_window(self.results)
				destory_window(self.prompt)
			end
			-- }}}

			local function get(key, layoutName)
				if key == "mount" then
					if layoutName == "default" then
						return defaultMount
					end
					if layoutName == "select" then
						return selectMount
					end
				elseif key == "unmount" then
					if layoutName == "default" then
						return defaultUnmount
					end
					if layoutName == "select" then
						return selectUnmount
					end
				end
			end

			return function(picker)
				local layout = Layout({
					picker = picker,
					mount = get("mount", name),
					unmount = get("unmount", name),
					update = function(self) end,
				})

				return layout
			end
		end

		require("telescope").setup({
			defaults = {
				mappings = {
					n = {
						["<esc>"] = require("telescope.actions").close,
						["<esc><esc>"] = require("telescope.actions").close,
					},
				},

				create_layout = TelescopeLayoutGen("default"),
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			},
		})

		require("telescope").load_extension("file_browser")
		require("telescope").load_extension("git_worktree")
		require("telescope").load_extension("ui-select")

		vim.api.nvim_create_autocmd("User", {
			pattern = "TelescopePreviewerLoaded",
			callback = function(args)
				-- vim.wo.winhighlight = "Normal:NormalFloatDarker"
			end,
		})
	end,
}
