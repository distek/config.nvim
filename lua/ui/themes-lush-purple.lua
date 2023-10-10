local lush = require("lush")
local hsl = lush.hsl

local lightenAmount = 1

local norm_fg = hsl(265, 65, 78).lighten(lightenAmount)
local norm_bg = hsl(282, 75, 6).lighten(lightenAmount)

local blue = hsl(245, 62, 77).lighten(lightenAmount)
local blue2 = hsl(245, 102, 77).lighten(lightenAmount)
local green = hsl(265, 34, 52).lighten(lightenAmount)
local light_blue = hsl(293, 62, 77).lighten(lightenAmount)
local bright_blue = hsl(293, 101, 77).lighten(lightenAmount)
local blue_green = hsl(260, 66, 68).lighten(lightenAmount)
local light_green = hsl(279, 93, 68).lighten(lightenAmount)
local light_red = hsl(0, 30, 65).lighten(lightenAmount)
local yellow_orange = hsl(71, 62, 68).lighten(lightenAmount)
local orange = hsl(279, 93, 68).lighten(lightenAmount)
local yellow = hsl(278, 70, 80).lighten(lightenAmount)
local pink = hsl(259, 66, 68).lighten(lightenAmount)
local red = hsl(0, 44, 48).lighten(lightenAmount)

local white = hsl(293, 62, 88).lighten(lightenAmount)
local gray = hsl(293, 17, 67).lighten(lightenAmount)
local gray2 = hsl(293, 10, 56).lighten(lightenAmount)
local gray3 = hsl(293, 9, 47).lighten(lightenAmount)
local black = hsl(282, 41, 15).lighten(lightenAmount)
local black2 = hsl(282, 24, 24).lighten(lightenAmount)
local black3 = hsl(282, 24, 34).lighten(lightenAmount)

vim.g.terminal_color_0 = black.hex
vim.g.terminal_color_1 = red.hex
vim.g.terminal_color_2 = green.hex
vim.g.terminal_color_3 = yellow.hex
vim.g.terminal_color_4 = blue.hex
vim.g.terminal_color_5 = orange.hex
vim.g.terminal_color_6 = blue_green.hex
vim.g.terminal_color_7 = white.hex
vim.g.terminal_color_8 = black2.hex
vim.g.terminal_color_9 = red.lighten(10).hex
vim.g.terminal_color_10 = green.lighten(10).hex
vim.g.terminal_color_11 = yellow.lighten(10).hex
vim.g.terminal_color_12 = blue.lighten(10).hex
vim.g.terminal_color_13 = orange.lighten(10).hex
vim.g.terminal_color_14 = blue_green.lighten(10).hex
vim.g.terminal_color_15 = white.lighten(10).hex

local error_red = hsl(8, 56, 54).lighten(lightenAmount)
local warn_yellow = hsl(56, 56, 54).lighten(lightenAmount)
local info_blue = hsl(188, 44, 43).lighten(lightenAmount)
local hint_gray = hsl(258, 56, 77).lighten(lightenAmount)

local selection_blue = hsl(279, 59, 68).lighten(lightenAmount)
local folded_blue = hsl(265, 34, 32).lighten(lightenAmount)
local float_border_fg = hsl(258, 56, 77).lighten(lightenAmount)
local indent_guide_fg = hsl(258, 23, 53).lighten(lightenAmount)
local indent_guide_context_fg = hsl(258, 23, 53).lighten(lightenAmount)
local label_fg = hsl(258, 56, 77).lighten(lightenAmount)

local git_green = hsl(116, 31, 37).lighten(lightenAmount)
local git_blue = hsl(183, 31, 37).lighten(lightenAmount)
local git_red = hsl(0, 44, 37).lighten(lightenAmount)

---@diagnostic disable
local theme = lush(function(injected_functions)
	local sym = injected_functions.sym
	return {

		--
		-- Preset
		--
		TabBorder({ fg = black2 }), -- tab.border, border to separate tabs from each other
		FloatBorder({ bg = norm_bg.darken(8) }),
		NormalFloat({ bg = norm_bg.darken(8) }),
		SelectionHighlightBackground({ bg = gray3 }),
		LightBulb({ fg = yellow_orange }),
		CodeLens({ fg = gray3 }),
		GutterGitModified({ fg = git_blue }),
		GutterGitAdded({ fg = git_green }),
		GutterGitDeleted({ fg = git_red }),
		Breadcrumb({ fg = gray, bg = norm_bg }),
		ScrollbarSlider({ bg = gray3 }),
		GhostText({ fg = gray }),
		Icon({ fg = white }),
		Description({ fg = gray2 }), -- descriptionForeground
		ProgressBar({ fg = info_blue }), -- progressBar.background
		-- Git diff
		DiffTextAdded({ bg = git_green }),
		DiffTextDeleted({ bg = git_red }),
		DiffTextChanged({ bg = git_blue }),
		DiffLineAdded({ bg = git_green.darken(10) }),
		DiffLineDeleted({ bg = git_red.darken(10) }),
		DiffLineChanged({ bg = git_blue.darken(10) }),
		-- Quickfix list (can be used to define qf syntax, e.g.,
		-- ~/.config/nvim/syntax/qf.vim)
		QfFileName({ fg = white }),
		QfSelection({ bg = norm_fg.darken(20) }), -- terminal.inactiveSelectionBackground
		QfText({ fg = norm_fg }), -- normal text in quickfix list

		--
		-- Editor
		--
		CursorLine({ bg = black }),
		CursorColumn({ bg = black }),
		ColorColumn({ bg = black2 }), -- #5a5a5a in VSCode (editorRuler.foreground) it's too bright
		Conceal({ fg = gray2 }),
		Cursor({ gui = "reverse" }),
		-- lCursor { },
		-- CursorIM { },
		Directory({ fg = blue }),
		DiffAdd({ DiffLineAdded }),
		DiffDelete({ DiffLineDeleted }),
		DiffChange({ DiffLineChanged }),
		DiffText({ DiffTextChanged }),
		EndOfBuffer({ fg = norm_bg }),
		-- TermCursor { },
		-- TermCursorNC { },
		ErrorMsg({ fg = error_red }),
		WinSeparator({ FloatBorder }), -- editorGroup.border
		VirtSplit({ WinSeparator }), -- deprecated and use WinSeparator instead
		LineNr({ fg = black3 }),
		CursorLineNr({ fg = orange }),
		Folded({ bg = folded_blue, fg = norm_bg.darken(40) }),
		CursorLineFold({ CursorLineNr }),
		FoldColumn({ LineNr }), -- #c5c5c5 in VSCode (editorGutter.foldingControlForeground) and it's too bright
		SignColumn({ bg = norm_bg }),
		IncSearch({ bg = gray2 }),
		-- Substitute { },
		MatchParen({ bg = gray, gui = "bold, underline" }),
		ModeMsg({ fg = norm_fg }),
		-- MsgArea { },
		-- MsgSeparator { },
		MoreMsg({ fg = norm_fg }),
		NonText({ fg = gray2 }),
		Normal({ fg = norm_fg, bg = norm_bg }),
		-- NormalNC { },
		Pmenu({ fg = norm_fg.lighten(30), bg = black2.darken(40) }),
		PmenuSel({ fg = white, bg = black2 }),
		PmenuSbar({ bg = black2 }),
		PmenuThumb({ bg = black3.lighten(10) }),
		Question({ fg = blue }),
		QuickFixLine({ QfSelection }),
		Search({ bg = folded_blue }),
		SpecialKey({ NonText }),
		SpellBad({ gui = "undercurl", sp = error_red }),
		SpellCap({ gui = "undercurl", sp = warn_yellow }),
		SpellLocal({ gui = "undercurl", sp = info_blue }),
		SpellRare({ gui = "undercurl", sp = info_blue }),
		StatusLine({ bg = black2 }),
		StatusLineNC({ fg = gray, bg = black2 }),
		TabLine({ fg = gray, bg = white }),
		TabLineFill({ fg = "NONE", bg = black.darken(40) }),
		TabLineSel({ fg = white, bg = norm_bg }),

		-- BarBar
		BufferOffset({ fg = pink, bg = black2 }),

		BufferCurrent({ fg = gray, bg = norm_bg }),
		BufferCurrentIndex({ fg = gray, bg = norm_bg }),
		BufferCurrentSign({ fg = gray, bg = norm_bg }),
		BufferCurrentMod({ fg = gray, bg = norm_bg }),
		BufferCurrentTarget({ fg = gray, bg = norm_bg }),

		BufferVisible({ fg = gray, bg = black }),
		BufferVisibleIndex({ fg = gray, bg = black }),
		BufferVisibleSign({ fg = gray, bg = black }),
		BufferVisibleMod({ fg = gray, bg = black }),
		BufferVisibleTarget({ fg = gray, bg = black }),

		BufferInactive({ fg = gray, bg = black }),
		BufferInactiveIndex({ fg = gray, bg = black }),
		BufferInactiveSign({ fg = gray, bg = black }),
		BufferInactiveMod({ fg = gray, bg = black }),
		BufferInactiveTarget({ fg = gray, bg = black }),

		Title({ fg = blue, gui = "bold" }),
		Visual({ bg = black.lighten(5) }),
		-- VisualNOS { },
		WarningMsg({ fg = warn_yellow }),
		Whitespace({ fg = gray3 }),
		WildMenu({ PmenuSel }),
		Winbar({ Breadcrumb }),
		WinbarNC({ Breadcrumb }),

		--
		-- Syntax
		--
		Comment({ fg = green, gui = "italic" }),

		Constant({ fg = blue }),
		String({ fg = orange }),
		Character({ Constant }),
		Number({ fg = light_green }),
		Boolean({ Constant }),
		Float({ Number }),

		Identifier({ fg = light_blue }),
		Function({ fg = yellow }),

		Statement({ fg = pink }),
		Conditional({ Statement }),
		Repeat({ Statement }),
		Label({ Statement }),
		Operator({ fg = norm_fg }),
		Keyword({ fg = blue }),
		Exception({ Statement }),

		PreProc({ fg = pink }),
		Include({ PreProc }),
		Define({ PreProc }),
		Macro({ PreProc }),
		PreCondit({ PreProc }),

		Type({ fg = blue }),
		StorageClass({ Type }),
		Structure({ Type }),
		Typedef({ Type }),

		Special({ fg = yellow_orange }),
		SpecialChar({ Special }),
		Tag({ Special }),
		Delimiter({ Special }),
		SpecialComment({ Special }),
		Debug({ Special }),

		Underlined({ gui = "underline" }),
		-- Ignore { },
		Error({ fg = error_red }),
		Todo({ fg = norm_bg, bg = yellow_orange, gui = "bold" }),

		--
		-- LSP
		--
		LspReferenceText({ SelectionHighlightBackground }),
		LspReferenceRead({ SelectionHighlightBackground }),
		LspReferenceWrite({ SelectionHighlightBackground }),
		LspCodeLens({ CodeLens }),
		-- LspCodeLensSeparator { }, -- Used to color the seperator between two or more code lens.
		LspSignatureActiveParameter({ fg = bright_blue }),

		--
		-- Diagnostics
		--
		DiagnosticError({ fg = error_red }),
		DiagnosticWarn({ fg = warn_yellow }),
		DiagnosticInfo({ fg = info_blue }),
		DiagnosticHint({ fg = hint_gray }),
		DiagnosticVirtualTextError({ DiagnosticError, bg = hsl("#332323") }),
		DiagnosticVirtualTextWarn({ DiagnosticWarn, bg = hsl("#2f2c1b") }),
		DiagnosticVirtualTextInfo({ DiagnosticInfo, bg = hsl("#212a35") }),
		DiagnosticVirtualTextHint({ DiagnosticHint, bg = black }),
		DiagnosticUnderlineError({ gui = "undercurl", sp = error_red }),
		DiagnosticUnderlineWarn({ gui = "undercurl", sp = warn_yellow }),
		DiagnosticUnderlineInfo({ gui = "undercurl", sp = info_blue }),
		DiagnosticUnderlineHint({ gui = "undercurl", sp = hint_gray }),
		DiagnosticFloatingError({ DiagnosticError }),
		DiagnosticFloatingWarn({ DiagnosticWarn }),
		DiagnosticFloatingInfo({ DiagnosticInfo }),
		DiagnosticFloatingHint({ DiagnosticHint }),
		DiagnosticSignError({ DiagnosticError }),
		DiagnosticSignWarn({ DiagnosticWarn }),
		DiagnosticSignInfo({ DiagnosticInfo }),
		DiagnosticSignHint({ DiagnosticHint }),

		--
		-- Treesitter
		--
		-- The obsolete TS* highlight groups are removed since this commit
		-- https://github.com/nvim-treesitter/nvim-treesitter/commit/42ab95d5e11f247c6f0c8f5181b02e816caa4a4f
		-- Now use the capture names directly as the highlight groups.
		-- (1). How to define the highlight group, see https://github.com/rktjmp/lush.nvim/issues/109
		-- (2). To find all the capture names, see https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md#highlights)

		-- Misc
		sym("@comment")({ Comment }),
		sym("@comment.documentation")({ sym("@comment") }),
		sym("@error")({ fg = error_red }),
		-- sym("@none") { },
		-- sym("@preproc") { },
		-- sym("@define") { },
		sym("@operator")({ fg = norm_fg }),

		-- Punctuation
		sym("@punctuation.delimiter")({ fg = norm_fg }),
		sym("@punctuation.bracket")({ fg = norm_fg }),
		sym("@punctuation.special")({ fg = norm_fg }),

		-- Literals
		-- sym("@string") { },
		sym("@string.documentation")({ fg = orange }),
		sym("@string.regex")({ fg = light_red }),
		sym("@string.escape")({ fg = yellow_orange }),
		-- sym("@string.special") { },
		-- sym("@character") { },
		-- sym("@character.special") { },
		-- sym("@boolean") { },
		-- sym("@number") { },
		-- sym("@float") { },

		-- Function
		-- sym("@function") { },
		sym("@function.builtin")({ Function }),
		sym("@function.call")({ Function }),
		sym("@function.macro")({ Function }),
		-- sym("@method") { },
		-- sym("@method.call") { },
		sym("@constructor")({ fg = blue_green }),
		sym("@parameter")({ fg = light_blue }),

		-- Keyword
		sym("@keyword")({ Keyword }),
		sym("@keyword.coroutine")({ fg = pink }),
		sym("@keyword.function")({ fg = blue }),
		sym("@keyword.operator")({ fg = norm_fg }),
		sym("@keyword.return")({ fg = pink }),
		-- sym("@conditional") { },
		-- sym("@conditional.ternary") { },
		-- sym("@repeat") { },
		-- sym("@debug") { },
		sym("@label")({ fg = label_fg }),
		-- sym("@include") { },
		-- sym("@exception") { },

		-- Types
		sym("@type")({ fg = blue_green }),
		sym("@type.builtin")({ fg = blue }),
		sym("@type.definition")({ fg = blue_green }),
		sym("@type.qualifier")({ fg = blue }),
		sym("@storageclass")({ fg = blue }),
		sym("@attribute")({ fg = blue_green }),
		sym("@field")({ fg = light_blue }),
		sym("@property")({ sym("@field") }),

		-- Identifiers
		sym("@variable")({ fg = light_blue }),
		sym("@variable.builtin")({ fg = blue }),
		-- sym("@constant") { },
		sym("@constant.builtin")({ Constant }),
		sym("@constant.macro")({ Constant }),
		sym("@namespace")({ fg = blue_green }),
		-- sym("@symbol") { },

		-- Text (Mainly for markup languages)
		sym("@text")({ fg = norm_fg }),
		sym("@text.strong")({ fg = norm_fg, gui = "bold" }),
		sym("@text.emphasis")({ fg = norm_fg, gui = "italic" }),
		sym("@text.underline")({ fg = norm_fg, gui = "underline" }),
		sym("@text.strike")({ fg = norm_fg, gui = "strikethrough" }),
		sym("@text.title")({ Title, gui = "bold" }),
		-- sym("@text.literal") { },
		-- sym("@text.quote") { },
		sym("@text.uri")({ Tag }),
		sym("@text.math")({ fg = blue_green }),
		-- sym("@text.environment") { },
		-- sym("@text.environment.name") { },
		sym("@text.reference")({ fg = orange }),
		sym("@text.todo")({ Todo }),
		sym("@text.note")({ fg = info_blue }),
		sym("@text.warning")({ fg = warn_yellow }),
		sym("@text.danger")({ fg = error_red }),
		sym("@text.diff.add")({ DiffTextAdded }),
		sym("@text.diff.delete")({ DiffTextDeleted }),

		-- Tags
		sym("@tag")({ fg = blue }),
		-- sym("@tag.attribute") { },
		sym("@tag.delimiter")({ fg = gray3 }),

		-- Conceal
		-- sym("@conceal") { },

		-- Spell
		-- sym("@spell") { },
		-- sym("@nospell") { },

		--
		-- LSP semantic tokens
		--
		-- The help page :h lsp-semantic-highlight
		-- A short guide: https://gist.github.com/swarn/fb37d9eefe1bc616c2a7e476c0bc0316
		-- Token types and modifiers are described here: https://code.visualstudio.com/api/language-extensions/semantic-highlight-guide
		sym("@lsp.type.namespace")({ fg = blue_green }),
		sym("@lsp.type.type")({ fg = blue_green }),
		sym("@lsp.type.class")({ fg = blue_green }),
		sym("@lsp.type.enum")({ fg = blue_green }),
		sym("@lsp.type.interface")({ fg = blue_green }),
		sym("@lsp.type.struct")({ fg = blue_green }),
		sym("@lsp.type.typeParameter")({ fg = blue_green }),
		sym("@lsp.type.parameter")({ fg = light_blue }),
		sym("@lsp.type.variable")({ fg = light_blue }),
		sym("@lsp.type.property")({ fg = light_blue }),
		sym("@lsp.type.enumMember")({ fg = blue2 }),
		-- sym("@lsp.type.event") { },  -- TODO: what is event property?
		sym("@lsp.type.function")({ fg = yellow }),
		sym("@lsp.type.method")({ fg = yellow }),
		sym("@lsp.type.macro")({ fg = blue }),
		sym("@lsp.type.keyword")({ fg = blue }),
		sym("@lsp.type.modifier")({ fg = blue }),
		sym("@lsp.type.comment")({ fg = green }),
		sym("@lsp.type.string")({ fg = orange }),
		sym("@lsp.type.number")({ fg = light_green }),
		sym("@lsp.type.regexp")({ fg = light_red }),
		sym("@lsp.type.operator")({ fg = norm_fg }),
		sym("@lsp.type.decorator")({ fg = yellow }),
		sym("@lsp.typemod.type.defaultLibrary")({ fg = blue_green }),
		sym("@lsp.typemod.class.defaultLibrary")({ fg = blue_green }),
		sym("@lsp.typemod.function.defaultLibrary")({ fg = yellow }),
		sym("@lsp.typemod.variable.readonly")({ fg = blue2 }),
		sym("@lsp.typemod.property.readonly")({ fg = blue2 }),
		-- Set injected highlights. Mainly for Rust doc comments and also works for
		-- other lsps that inject tokens in comments.
		-- Ref: https://github.com/folke/tokyonight.nvim/pull/340
		sym("@lsp.typemod.operator.injected")({ sym("@lsp.type.operator") }),
		sym("@lsp.typemod.string.injected")({ sym("@lsp.type.string") }),
		sym("@lsp.typemod.variable.injected")({ sym("@lsp.type.variable") }),

		--
		-- nvim-lspconfig
		--
		-- LspInfoTitle { },
		-- LspInfoList { },
		-- LspInfoFiletype { },
		-- LspInfoTip { },
		LspInfoBorder({ FloatBorder }),

		--
		-- nvim-cmp
		--
		CmpItemAbbrDeprecated({
			fg = gray3,
			bg = "NONE",
			gui = "strikethrough",
		}),
		CmpItemAbbrMatch({ fg = bright_blue, bg = "NONE" }),
		CmpItemAbbrMatchFuzzy({ CmpItemAbbrMatch }),
		CmpItemMenu({ Description }),
		CmpItemKindText({ fg = white, bg = "NONE" }),
		CmpItemKindMethod({ fg = bright_blue, bg = "NONE" }),
		CmpItemKindFunction({ CmpItemKindMethod }),
		CmpItemKindConstructor({ CmpItemKindFunction }),
		CmpItemKindField({ fg = green, bg = "NONE" }),
		CmpItemKindVariable({ CmpItemKindField }),
		CmpItemKindClass({ fg = yellow_orange, bg = "NONE" }),
		CmpItemKindInterface({ CmpItemKindField }),
		CmpItemKindModule({ CmpItemKindText }),
		CmpItemKindProperty({ CmpItemKindText }),
		CmpItemKindUnit({ CmpItemKindText }),
		CmpItemKindValue({ CmpItemKindText }),
		CmpItemKindEnum({ CmpItemKindClass }),
		CmpItemKindKeyword({ CmpItemKindText }),
		CmpItemKindSnippet({ CmpItemKindText }),
		CmpItemKindColor({ CmpItemKindText }),
		CmpItemKindFile({ CmpItemKindText }),
		CmpItemKindReference({ CmpItemKindText }),
		CmpItemKindFolder({ CmpItemKindText }),
		CmpItemKindEnumMember({ CmpItemKindField }),
		CmpItemKindConstant({ CmpItemKindText }),
		CmpItemKindStruct({ CmpItemKindText }),
		CmpItemKindEvent({ CmpItemKindClass }),
		CmpItemKindOperator({ CmpItemKindText }),
		CmpItemKindTypeParameter({ CmpItemKindText }),
		-- Predefined for the winhighlight config of cmp float window
		SuggestWidgetBorder({ FloatBorder }),
		SuggestWidgetSelect({ bg = selection_blue }),

		--
		-- Aerial
		--
		AerialTextIcon({ CmpItemKindText }),
		AerialMethodIcon({ CmpItemKindMethod }),
		AerialFunctionIcon({ CmpItemKindFunction }),
		AerialConstructorIcon({ CmpItemKindConstructor }),
		AerialFieldIcon({ CmpItemKindField }),
		AerialVariableIcon({ CmpItemKindVariable }),
		AerialClassIcon({ CmpItemKindClass }),
		AerialInterfaceIcon({ CmpItemKindInterface }),
		AerialModuleIcon({ CmpItemKindModule }),
		AerialPropertyIcon({ CmpItemKindProperty }),
		AerialUnitIcon({ CmpItemKindUnit }),
		AerialValueIcon({ CmpItemKindValue }),
		AerialEnumIcon({ CmpItemKindEnum }),
		AerialKeywordIcon({ CmpItemKindKeyword }),
		AerialSnippetIcon({ CmpItemKindSnippet }),
		AerialColorIcon({ CmpItemKindColor }),
		AerialFileIcon({ CmpItemKindFile }),
		AerialReferenceIcon({ CmpItemKindReference }),
		AerialFolderIcon({ CmpItemKindFolder }),
		AerialEnumMemberIcon({ CmpItemKindEnumMember }),
		AerialConstantIcon({ CmpItemKindConstant }),
		AerialStructIcon({ CmpItemKindStruct }),
		AerialEventIcon({ CmpItemKindEvent }),
		AerialOperatorIcon({ CmpItemKindOperator }),
		AerialTypeParameterIcon({ CmpItemKindTypeParameter }),

		--
		-- Gitsigns
		--
		GitSignsAdd({ GutterGitAdded }),
		GitSignsChange({ GutterGitModified }),
		GitSignsDelete({ GutterGitDeleted }),
		GitSignsAddNr({ GitSignsAdd }),
		GitSignsChangeNr({ GitSignsChange }),
		GitSignsDeleteNr({ GitSignsDelete }),
		GitSignsAddLn({ DiffAdd }),
		GitSignsChangeLn({ DiffChange }),
		GitSignsDeleteLn({ DiffDelete }),
		GitSignsAddInline({ DiffTextAdded }),
		GitSignsChangeInline({ DiffTextChanged }),
		GitSignsDeleteInline({ DiffTextDeleted }),

		--
		-- vim-illuminate
		--
		IlluminatedWordText({ SelectionHighlightBackground }),
		IlluminatedWordRead({ SelectionHighlightBackground }),
		IlluminatedWordWrite({ SelectionHighlightBackground }),

		--
		-- Telescope
		--
		TelescopeBorder({ FloatBorder }),
		TelescopePromptBorder({ TelescopeBorder }),
		TelescopeResultsBorder({ TelescopePromptBorder }),
		TelescopePreviewBorder({ TelescopePromptBorder }),
		TelescopeSelection({ PmenuSel }),
		TelescopeSelectionCaret({ TelescopeSelection }),
		TelescopeMultiIcon({ fg = blue_green }),
		TelescopeMatching({ CmpItemAbbrMatch }),
		TelescopeNormal({ Normal }),
		TelescopePromptPrefix({ Icon }),

		--
		-- Harpoon
		--
		HarpoonBorder({ TelescopeBorder }),
		HarpoonWindow({ TelescopeNormal }),

		--
		-- fFHighlight
		--
		fFHintWords({ gui = "underline", sp = "yellow" }),
		fFHintCurrentWord({ gui = "undercurl", sp = "yellow" }),

		--
		-- indent-blankline
		--
		IndentBlanklineChar({ fg = indent_guide_fg }),
		IndentBlanklineSpaceChar({ IndentBlanklineChar }),
		IndentBlanklineSpaceCharBlankline({ IndentBlanklineChar }),
		IndentBlanklineContextChar({ fg = indent_guide_context_fg }),
		IndentBlanklineContextSpaceChar({ IndentBlanklineContextChar }),
		IndentBlanklineContextStart({
			gui = "underline",
			sp = indent_guide_context_fg,
		}),

		--
		-- hlslens
		--
		HlSearchNear({ IncSearch }),
		HlSearchLens({ Description }),
		HlSearchLensNear({ HlSearchLens }),

		--
		-- Symbols-outline
		--
		FocusedSymbol({ fg = white, bg = selection_blue }),
		SymbolsOutlineConnector({ fg = gray3 }),

		--
		-- mg979/tabline.nvim
		--
		TSelect({ TabLineSel }),
		TVisible({ TabLine }),
		THidden({ TabLine }),
		TExtra({ TabLine }),
		TSpecial({ TabLine }),
		TFill({ TabLineFill }),
		TCorner({ fg = white, bg = black2 }),
		TNumSel({ TSelect }),
		TNum({ TabLine }),
		TSelectMod({ TSelect }),
		TVisibleMod({ TVisible }),
		THiddenMod({ THidden }),
		TExtraMod({ TExtra }),
		TSpecialMod({ TSpecial }),
		TSelectDim({ TSelect }),
		TVisibleDim({ TVisible }),
		THiddenDim({ THidden }),
		TExtraDim({ TExtra }),
		TSpecialDim({ TSpecial }),
		TSelectSep({ TabBorder }),
		TVisibleSep({ TabBorder }),
		THiddenSep({ TabBorder }),
		TExtraSep({ TabBorder }),
		TSpecialSep({ TabBorder }),

		NeoTreeNormal({ bg = norm_bg.darken(8) }),
		NeoTreeEndOfBuffer({ bg = norm_bg.darken(8) }),
		NeoTreeNormalNC({ bg = norm_bg.darken(8) }),
		NeoTreeCursorLine({ bg = norm_bg.darken(9) }),

		FNoteNormal({ bg = norm_bg.darken(8) }),
		FNoteEndOfBuffer({ bg = norm_bg.darken(8) }),
		FNoteNormalNC({ bg = norm_bg.darken(8) }),
		FNoteCursorLine({ bg = norm_bg.darken(9) }),

		VertSplit({ bg = norm_bg.darken(9) }),
	}
end)

lush(theme)

return theme
