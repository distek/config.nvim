Util.CreateDailyNote = function()
	-- Get current date in YYYY-MM-DD format
	local date = os.date("%Y-%m-%d")

	-- Get the week number of the year
	local week_number = os.date("%V") -- ISO 8601 week number (01-53)

	-- Get the current working directory
	local cwd = vim.fn.getcwd()

	-- Create the Daily directory path
	local daily_dir = cwd .. "/Daily"

	-- Create the week directory path
	local week_dir = daily_dir .. "/" .. week_number

	-- Create the directories if they don't exist
	vim.fn.mkdir(week_dir, "p")

	-- Create the full file path
	local filepath = week_dir .. "/" .. date .. ".md"

	-- Open the file in a new buffer
	vim.cmd("edit " .. vim.fn.fnameescape(filepath))

	-- Optional: Add a template if the file is new
	if vim.fn.getfsize(filepath) <= 0 then
		-- Add a simple template for new files
		local lines = {
			"# Daily Note - " .. os.date("%B %d, %Y"),
			"",
			"## Todo",
			"",
			"## Completed",
			"",
			"## Misc",
			"",
		}
		vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

		-- Move cursor to the first task line
		vim.api.nvim_win_set_cursor(0, { 3, 0 })
	end
end

-- Create the user command
vim.api.nvim_create_user_command("Daily", Util.CreateDailyNote, {
	desc = "Create or open today's daily note",
})
