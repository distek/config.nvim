return function()
	require("bufferline").setup({
		highlights = {
			background = {
				bg = "#121418",
				fg = "#6866b2",
				hl_group = "BufferLineBackground",
			},
			buffer = {
				bg = "#121418",
				fg = "#6866b2",
				hl_group = "BufferLineBuffer",
			},
			buffer_selected = {
				bg = "#181b20",
				bold = true,
				fg = "#b5b4d9",
				hl_group = "BufferLineBufferSelected",
				italic = true,
				underline = false,
			},
			buffer_visible = {
				bg = "#16181d",
				bold = false,
				fg = "#6866b2",
				hl_group = "BufferLineBufferVisible",
				italic = false,
			},
			close_button = {
				bg = "#121418",
				fg = "#6866b2",
				hl_group = "BufferLineCloseButton",
			},
			close_button_selected = {
				bg = "#181b20",
				fg = "#b5b4d9",
				hl_group = "BufferLineCloseButtonSelected",
				underline = false,
			},
			close_button_visible = {
				bg = "#16181d",
				fg = "#6866b2",
				hl_group = "BufferLineCloseButtonVisible",
			},
			diagnostic = {
				bg = "#121418",
				fg = "#4e4c85",
				hl_group = "BufferLineDiagnostic",
			},
			diagnostic_selected = {
				bg = "#181b20",
				bold = true,
				fg = "#8787a2",
				hl_group = "BufferLineDiagnosticSelected",
				italic = true,
				underline = false,
			},
			diagnostic_visible = {
				bg = "#16181d",
				fg = "#4e4c85",
				hl_group = "BufferLineDiagnosticVisible",
			},
			duplicate = {
				bg = "#121418",
				fg = "#6260a9",
				hl_group = "BufferLineDuplicate",
				italic = true,
			},
			duplicate_selected = {
				bg = "#181b20",
				fg = "#6260a9",
				hl_group = "BufferLineDuplicateSelected",
				italic = true,
				underline = false,
			},
			duplicate_visible = {
				bg = "#16181d",
				fg = "#6260a9",
				hl_group = "BufferLineDuplicateVisible",
				italic = true,
			},
			error = {
				bg = "#121418",
				fg = "#6866b2",
				hl_group = "BufferLineError",
				sp = "#cb5a48",
			},
			error_diagnostic = {
				bg = "#121418",
				fg = "#4e4c85",
				hl_group = "BufferLineErrorDiagnostic",
				sp = "#984336",
			},
			error_diagnostic_selected = {
				bg = "#181b20",
				bold = true,
				fg = "#984336",
				hl_group = "BufferLineErrorDiagnosticSelected",
				italic = true,
				sp = "#984336",
				underline = false,
			},
			error_diagnostic_visible = {
				bg = "#16181d",
				fg = "#4e4c85",
				hl_group = "BufferLineErrorDiagnosticVisible",
			},
			error_selected = {
				bg = "#181b20",
				bold = true,
				fg = "#cb5a48",
				hl_group = "BufferLineErrorSelected",
				italic = true,
				sp = "#cb5a48",
				underline = false,
			},
			error_visible = {
				bg = "#16181d",
				bold = false,
				fg = "#6866b2",
				hl_group = "BufferLineErrorVisible",
				italic = false,
			},
			fill = {
				bg = "#0d0e11",
				fg = "#6866b2",
				hl_group = "BufferLineFill",
			},
			group_label = {
				bg = "#6866b2",
				fg = "#0d0e11",
				hl_group = "BufferLineGroupLabel",
			},
			group_separator = {
				bg = "#0d0e11",
				fg = "#6866b2",
				hl_group = "BufferLineGroupSeparator",
			},
			hint = {
				bg = "#121418",
				fg = "#6866b2",
				hl_group = "BufferLineHint",
				sp = "#b7a4e5",
			},
			hint_diagnostic = {
				bg = "#121418",
				fg = "#4e4c85",
				hl_group = "BufferLineHintDiagnostic",
				sp = "#897bab",
			},
			hint_diagnostic_selected = {
				bg = "#181b20",
				bold = true,
				fg = "#897bab",
				hl_group = "BufferLineHintDiagnosticSelected",
				italic = true,
				sp = "#897bab",
				underline = false,
			},
			hint_diagnostic_visible = {
				bg = "#16181d",
				fg = "#4e4c85",
				hl_group = "BufferLineHintDiagnosticVisible",
			},
			hint_selected = {
				bg = "#181b20",
				bold = true,
				fg = "#b7a4e5",
				hl_group = "BufferLineHintSelected",
				italic = true,
				sp = "#b7a4e5",
				underline = false,
			},
			hint_visible = {
				bg = "#16181d",
				bold = false,
				fg = "#6866b2",
				hl_group = "BufferLineHintVisible",
				italic = false,
			},
			indicator_selected = {
				bg = "#181b20",
				fg = "#c7cdd6",
				hl_group = "BufferLineIndicatorSelected",
				underline = false,
			},
			indicator_visible = {
				bg = "#16181d",
				fg = "#16181d",
				hl_group = "BufferLineIndicatorVisible",
			},
			info = {
				bg = "#121418",
				fg = "#6866b2",
				hl_group = "BufferLineInfo",
				sp = "#3f94a2",
			},
			info_diagnostic = {
				bg = "#121418",
				fg = "#4e4c85",
				hl_group = "BufferLineInfoDiagnostic",
				sp = "#2f6f79",
			},
			info_diagnostic_selected = {
				bg = "#181b20",
				bold = true,
				fg = "#2f6f79",
				hl_group = "BufferLineInfoDiagnosticSelected",
				italic = true,
				sp = "#2f6f79",
				underline = false,
			},
			info_diagnostic_visible = {
				bg = "#16181d",
				fg = "#4e4c85",
				hl_group = "BufferLineInfoDiagnosticVisible",
			},
			info_selected = {
				bg = "#181b20",
				bold = true,
				fg = "#3f94a2",
				hl_group = "BufferLineInfoSelected",
				italic = true,
				sp = "#3f94a2",
				underline = false,
			},
			info_visible = {
				bg = "#16181d",
				bold = false,
				fg = "#6866b2",
				hl_group = "BufferLineInfoVisible",
				italic = false,
			},
			modified = {
				bg = "#121418",
				fg = "#a0ba4a",
				hl_group = "BufferLineModified",
			},
			modified_selected = {
				bg = "#181b20",
				fg = "#a0ba4a",
				hl_group = "BufferLineModifiedSelected",
				underline = false,
			},
			modified_visible = {
				bg = "#16181d",
				fg = "#a0ba4a",
				hl_group = "BufferLineModifiedVisible",
			},
			numbers = {
				bg = "#121418",
				fg = "#6866b2",
				hl_group = "BufferLineNumbers",
			},
			numbers_selected = {
				bg = "#181b20",
				bold = true,
				fg = "#b5b4d9",
				hl_group = "BufferLineNumbersSelected",
				italic = true,
				underline = false,
			},
			numbers_visible = {
				bg = "#16181d",
				fg = "#6866b2",
				hl_group = "BufferLineNumbersVisible",
			},
			offset_separator = {
				bg = "#0d0e11",
				fg = "#b5b4d9",
				hl_group = "BufferLineOffsetSeparator",
			},
			pick = {
				bg = "#121418",
				bold = true,
				fg = "#cb5a48",
				hl_group = "BufferLinePick",
				italic = true,
			},
			pick_selected = {
				bg = "#181b20",
				bold = true,
				fg = "#cb5a48",
				hl_group = "BufferLinePickSelected",
				italic = true,
				underline = false,
			},
			pick_visible = {
				bg = "#16181d",
				bold = true,
				fg = "#cb5a48",
				hl_group = "BufferLinePickVisible",
				italic = true,
			},
			separator = {
				bg = "#121418",
				fg = "#0d0e11",
				hl_group = "BufferLineSeparator",
			},
			separator_selected = {
				bg = "#181b20",
				fg = "#0d0e11",
				hl_group = "BufferLineSeparatorSelected",
				underline = false,
			},
			separator_visible = {
				bg = "#16181d",
				fg = "#0d0e11",
				hl_group = "BufferLineSeparatorVisible",
			},
			tab = {
				bg = "#121418",
				fg = "#6866b2",
				hl_group = "BufferLineTab",
			},
			tab_close = {
				bg = "#121418",
				fg = "#6866b2",
				hl_group = "BufferLineTabClose",
			},
			tab_selected = {
				bg = "#181b20",
				bold = false,
				fg = "#c7cdd6",
				hl_group = "BufferLineTabSelected",
				underline = false,
			},
			tab_separator = {
				bg = "#121418",
				fg = "#0d0e11",
				hl_group = "BufferLineTabSeparator",
			},
			tab_separator_selected = {
				bg = "#181b20",
				fg = "#0d0e11",
				hl_group = "BufferLineTabSeparatorSelected",
				underline = false,
			},
			trunc_marker = {
				bg = "#0d0e11",
				fg = "#6866b2",
				hl_group = "BufferLineTruncMarker",
			},
			warning = {
				bg = "#121418",
				fg = "#6866b2",
				hl_group = "BufferLineWarning",
				sp = "#cbc348",
			},
			warning_diagnostic = {
				bg = "#121418",
				fg = "#4e4c85",
				hl_group = "BufferLineWarningDiagnostic",
				sp = "#989236",
			},
			warning_diagnostic_selected = {
				bg = "#181b20",
				bold = true,
				fg = "#989236",
				hl_group = "BufferLineWarningDiagnosticSelected",
				italic = true,
				sp = "#989236",
				underline = false,
			},
			warning_diagnostic_visible = {
				bg = "#16181d",
				fg = "#4e4c85",
				hl_group = "BufferLineWarningDiagnosticVisible",
			},
			warning_selected = {
				bg = "#181b20",
				bold = true,
				fg = "#cbc348",
				hl_group = "BufferLineWarningSelected",
				italic = true,
				sp = "#cbc348",
				underline = false,
			},
			warning_visible = {
				bg = "#16181d",
				bold = false,
				fg = "#6866b2",
				hl_group = "BufferLineWarningVisible",
				italic = false,
			},
		},
		options = {
			mode = "buffers", -- set to "tabs" to only show tabpages instead
			style_preset = require("bufferline").style_preset.default, -- or bufferline.style_preset.minimal,
			themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
			numbers = "none",
			close_command = "bdelete %d", -- can be a string | function, | false see "Mouse actions"
			right_mouse_command = nil, -- can be a string | function | false, see "Mouse actions"
			left_mouse_command = "buffer %d", -- can be a string | function, | false see "Mouse actions"
			middle_mouse_command = nil, -- can be a string | function, | false see "Mouse actions"
			indicator = {
				-- icon = '▎', -- this should be omitted if indicator style is not 'icon'
				style = "none",
			},
			buffer_close_icon = "󰅖",
			modified_icon = "●",
			close_icon = "",
			left_trunc_marker = "",
			right_trunc_marker = "",
			max_name_length = 18,
			max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
			truncate_names = true, -- whether or not tab names should be truncated
			tab_size = 18,
			diagnostics = "nvim_lsp",
			diagnostics_update_in_insert = false,
			-- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
			-- diagnostics_indicator = function(count, level, diagnostics_dict, context)
			--     return "("..count..")"
			-- end,
			-- NOTE: this will be called a lot so don't do any heavy processing here
			-- custom_filter = function(buf_number, buf_numbers)
			--     -- filter out filetypes you don't want to see
			--     if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
			--         return true
			--     end
			--     -- filter out by buffer name
			--     if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
			--         return true
			--     end
			--     -- filter out based on arbitrary rules
			--     -- e.g. filter out vim wiki buffer from tabline in your work repo
			--     if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
			--         return true
			--     end
			--     -- filter out by it's index number in list (don't show first buffer)
			--     if buf_numbers[1] ~= buf_number then
			--         return true
			--     end
			-- end,
			offsets = {
				{
					filetype = "neo-tree",
					text = "Neovim",
					text_align = "center",
					separator = " ",
				},
				{
					filetype = "Outline",
					text = "",
					text_align = "center",
					separator = " ",
				},
				{
					filetype = "edgy",
					text = "",
					text_align = "center",
					separator = " ",
				},
			},
			color_icons = true, -- whether or not to add the filetype icon highlights
			show_buffer_icons = true, -- disable filetype icons for buffers
			show_buffer_close_icons = true,
			show_close_icon = true,
			show_tab_indicators = true,
			show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
			persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
			move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
			-- can also be a table containing 2 custom separators
			-- [focused and unfocused]. eg: { '|', '|' }
			separator_style = "slant",
			enforce_regular_tabs = false,
			always_show_bufferline = true,
			-- hover = {
			-- 	enabled = true,
			-- 	delay = 200,
			-- 	reveal = { "close" },
			-- },
			sort_by = "insert_after_current",
		},
	})
end
