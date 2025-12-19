local lush = require("lush")
local hsl = lush.hsl

local lightenAmount = 8

local norm_fg = hsl(241, 33, 78).lighten(lightenAmount)
local norm_bg = hsl(215, 15, 10).lighten(lightenAmount)

local black = hsl(215, 15, 25).lighten(lightenAmount)
local red = hsl(0, 30, 50)
local green = hsl(74, 45, 51)
local yellow = hsl(49, 55, 52)
local blue = hsl(204, 41, 53)
local magenta = hsl(276, 28, 52)
local cyan = hsl(162, 30, 50)
local white = hsl(215, 15, 81)

local gray = hsl(215, 15, 26).lighten(15)

local diagnostic_error = hsl(8, 56, 54).lighten(lightenAmount)
local diagnostic_warning = hsl(56, 56, 54).lighten(lightenAmount)
local diagnostic_info = hsl(188, 44, 43).lighten(lightenAmount)
local diagnostic_hint = hsl(258, 56, 77).lighten(lightenAmount)

local git_green = hsl(116, 31, 37).lighten(lightenAmount)
local git_blue = hsl(183, 31, 37).lighten(lightenAmount)
local git_red = hsl(0, 44, 37).lighten(lightenAmount)

local statusColBG = norm_bg.lighten(10)

-- vim.g.terminal_color_0 = black.lighten(10).hex
-- vim.g.terminal_color_1 = red.lighten(10).hex
-- vim.g.terminal_color_2 = green.lighten(10).hex
-- vim.g.terminal_color_3 = yellow.lighten(10).hex
-- vim.g.terminal_color_4 = blue.lighten(10).hex
-- vim.g.terminal_color_5 = magenta.lighten(10).hex
-- vim.g.terminal_color_6 = cyan.lighten(10).hex
-- vim.g.terminal_color_7 = white.lighten(10).hex
-- vim.g.terminal_color_8 = black.lighten(20).hex
-- vim.g.terminal_color_9 = red.lighten(20).hex
-- vim.g.terminal_color_10 = green.lighten(20).hex
-- vim.g.terminal_color_11 = yellow.lighten(20).hex
-- vim.g.terminal_color_12 = blue.lighten(20).hex
-- vim.g.terminal_color_13 = magenta.lighten(20).hex
-- vim.g.terminal_color_14 = cyan.lighten(20).hex
-- vim.g.terminal_color_15 = white.lighten(20).hex

---@diagnostic disable: undefined-global
local theme = lush(function(inj)
	local sym = inj.sym
	return {
		Black({ fg = black.lighten(10).hex }),
		Blend100({ bg = "NONE" }),
		Blue({ fg = blue.lighten(10).hex }),
		Boolean({ fg = magenta }),
		BufferCurrent({ fg = white, bg = norm_bg }),
		BufferCurrentIndex({ fg = white, bg = norm_bg }),
		BufferCurrentMod({ fg = white, bg = norm_bg }),
		BufferCurrentSign({ fg = white, bg = norm_bg }),
		BufferCurrentTarget({ fg = white, bg = norm_bg }),
		BufferFill({ bg = norm_bg.lighten(10) }),
		BufferInactive({ fg = gray.lighten(40), bg = black }),
		BufferInactiveIndex({ fg = gray.lighten(40), bg = black }),
		BufferInactiveMod({ fg = gray.lighten(40), bg = black }),
		BufferInactiveSign({ fg = gray.lighten(40), bg = black }),
		BufferInactiveTarget({ fg = gray.lighten(40), bg = black }),
		BufferOffset({ fg = magenta.lighten(30).saturate(30), bg = black }),
		BufferVisible({ fg = gray.lighten(50), bg = black.lighten(10) }),
		BufferVisibleIndex({ fg = gray.lighten(50), bg = black.lighten(10) }),
		BufferVisibleMod({ fg = gray.lighten(50), bg = black.lighten(10) }),
		BufferVisibleSign({ fg = gray.lighten(50), bg = black.lighten(10) }),
		BufferVisibleTarget({ fg = gray.lighten(50), bg = black.lighten(10) }),
		Character({ fg = blue }),
		CmpItemAbbrMatch({ fg = blue }),
		ColorColumn({ bg = norm_bg.lighten(10) }),
		Comment({ fg = norm_fg.darken(30) }),
		Conceal({ fg = yellow, bg = norm_bg }),
		Conditional({ fg = blue }),
		Constant({ fg = blue }),
		Cursor({ fg = norm_bg, bg = norm_fg }),
		CursorColumn({ bg = norm_bg.lighten(10) }),
		CursorLine({ bg = norm_bg.lighten(10) }),
		CursorLineNr({ bg = norm_bg.lighten(10), fg = norm_fg.lighten(30) }),
		Cyan({ fg = cyan.lighten(10).hex }),
		DapBreakpoint({ fg = red, bg = statusColBG }),
		DapLogPoint({ fg = yellow, bg = statusColBG }),
		DapStopped({ fg = blue, bg = statusColBG }),
		Debug({}),
		Delimiter({ fg = blue }),
		DiagnosticError({ fg = diagnostic_error }),
		DiagnosticFloatingError({ fg = diagnostic_error }),
		DiagnosticFloatingHint({ fg = diagnostic_hint }),
		DiagnosticFloatingInfo({ fg = diagnostic_info }),
		DiagnosticFloatingWarn({ fg = diagnostic_warning }),
		DiagnosticHint({ fg = diagnostic_hint }),
		DiagnosticInfo({ fg = diagnostic_info }),
		DiagnosticSignError({ fg = diagnostic_error, bg = statusColBG }),
		DiagnosticSignHint({ fg = diagnostic_hint, bg = statusColBG }),
		DiagnosticSignInfo({ fg = diagnostic_info, bg = statusColBG }),
		DiagnosticSignWarn({ fg = diagnostic_warning, bg = statusColBG }),
		DiagnosticUnderlineError({ fg = diagnostic_error }),
		DiagnosticUnderlineHint({ fg = diagnostic_hint }),
		DiagnosticUnderlineInfo({ fg = diagnostic_info }),
		DiagnosticUnderlineWarn({ fg = diagnostic_warning }),
		DiagnosticVirtualTextError({ fg = diagnostic_error }),
		DiagnosticVirtualTextHint({ fg = diagnostic_hint }),
		DiagnosticVirtualTextInfo({ fg = diagnostic_info }),
		DiagnosticVirtualTextWarn({ fg = diagnostic_warning }),
		DiagnosticWarn({ fg = diagnostic_warning }),
		DiffLineAdded({ bg = git_green.darken(10) }),
		DiffLineChanged({ bg = git_blue.darken(10) }),
		DiffLineDeleted({ bg = git_red.darken(10) }),
		DiffTextAdded({ bg = git_green }),
		DiffTextChanged({ bg = git_blue }),
		DiffTextDeleted({ bg = git_red }),
		Directory({ fg = blue }),
		EdgyBuffersNormal({ bg = norm_bg.lighten(25) }),
		EdgyBuffersNormalNC({ bg = norm_bg.lighten(25) }),
		EdgyFileTreeNormal({ bg = norm_bg.lighten(5) }),
		EdgyHelpNormal({ bg = norm_bg.lighten(5) }),
		EdgyQuickfixNormal({ bg = norm_bg.darken(20) }),
		EdgyTermListNormal({ bg = norm_bg.lighten(5) }),
		EdgyTermNormal({ bg = norm_bg.darken(30) }),
		EdgyWinBar({ bg = norm_bg.darken(100) }),
		Error({}),
		ErrorMsg({ fg = red }),
		FNoteCursorLine({ bg = norm_bg.darken(9) }),
		FNoteEndOfBuffer({ bg = norm_bg.darken(8) }),
		FNoteNormal({ bg = norm_bg.darken(8) }),
		FNoteNormalNC({ bg = norm_bg.darken(8) }),
		Float({ fg = red }),
		FloatShadow({ blend = 15, bg = norm_bg.darken(20) }),
		FoldColumn({ bg = norm_bg.lighten(10), fg = norm_fg.lighten(10) }),
		Folded({ bg = norm_bg.lighten(15), fg = norm_fg }),
		Function({ fg = blue.lighten(20) }),
		GitSignsAdd({ fg = green, bg = statusColBG }),
		GitSignsChange({ fg = green, bg = statusColBG }),
		GitSignsChangedelete({ fg = yellow, bg = statusColBG }),
		GitSignsDelete({ fg = red, bg = statusColBG }),
		GitSignsTopdelete({ fg = red, bg = statusColBG }),
		GitSignsUntracked({ fg = gray, bg = statusColBG }),
		Green({ fg = green.lighten(10).hex }),
		HLChunkIndicator({ fg = blue.darken(20) }),
		HideCursor({ blend = 100 }),
		Identifier({ fg = magenta.saturate(20).lighten(30) }),
		Ignore({}),
		IncSearch({ bg = norm_bg.lighten(30) }),
		IndentBlanklineChar({ fg = norm_fg.darken(10) }),
		IndentBlanklineContextChar({ fg = blue }),
		IndentBlanklineContextStart({ gui = "undercurl", guisp = blue }),
		Keyword({ fg = red.lighten(10).desaturate(30) }),
		Label({ fg = green }),
		LightBlack({ fg = black.lighten(20).hex }),
		LightBlue({ fg = blue.lighten(20).hex }),
		LightCyan({ fg = cyan.lighten(20).hex }),
		LightGreen({ fg = green.lighten(20).hex }),
		LightMagenta({ fg = magenta.lighten(20).hex }),
		LightRed({ fg = red.lighten(20).hex }),
		LightWhite({ fg = white.lighten(20).hex }),
		LightYellow({ fg = yellow.lighten(20).hex }),
		LineNr({ bg = norm_bg.lighten(10), fg = norm_fg.darken(20) }),
		LspCodeLens({ fg = diagnostic_error }),
		LspSignatureActiveParameter({ bg = yellow.darken(60) }),
		Magenta({ fg = magenta.lighten(10).hex }),
		MoreMsg({ fg = green }),
		NeoTreeCursorLine({ bg = norm_bg.darken(9) }),
		NeoTreeDimText({ fg = gray.lighten(20) }),
		NeoTreeDirectoryIcon({ Directory }),
		NeoTreeDirectoryName({ Directory }),
		NeoTreeDotfile({ fg = gray.lighten(20) }),
		NeoTreeFileNameOpened({ gui = "bold" }),
		NeoTreeGitAdded({ fg = git_green, bg = norm_bg.lighten(5) }),
		NeoTreeGitConflict({ fg = yellow, bg = norm_bg.lighten(5) }),
		NeoTreeGitDeleted({ fg = git_red, bg = norm_bg.lighten(5) }),
		NeoTreeGitIgnored({ fg = gray.lighten(18), bg = norm_bg.lighten(5) }),
		NeoTreeGitModified({
			fg = git_blue.darken(10),
			bg = norm_bg.lighten(5),
		}),
		NeoTreeGitStaged({ bg = norm_bg.lighten(5) }),
		NeoTreeGitUnstaged({
			fg = git_green.darken(10),
			bg = norm_bg.lighten(5),
		}),
		NeoTreeGitUntracked({ fg = yellow, bg = norm_bg.lighten(5) }),
		NeoTreeModified({ fg = blue }),
		NeoTreeRootName({ fg = white }),
		NeoTreeRootName_35({ fg = white.darken(60) }),
		NeoTreeRootName_60({ fg = white.darken(50) }),
		NeoTreeRootName_68({ fg = white.darken(30) }),
		NeoTreeTitleBar({}),
		NoiceCmdLine({ bg = norm_bg.lighten(15) }),
		NoiceCmdlinePopupBorderCalculator({
			fg = yellow,
			bg = norm_bg.lighten(10),
		}),
		NoiceCmdlinePopupBorderCmdline({ fg = blue, bg = norm_bg.lighten(10) }),
		NoiceCmdlinePopupBorderFilter({ fg = red, bg = norm_bg.lighten(10) }),
		NoiceCmdlinePopupBorderHelp({ fg = green, bg = norm_bg.lighten(10) }),
		NoiceCmdlinePopupBorderIncRename({
			fg = magenta,
			bg = norm_bg.lighten(10),
		}),
		NoiceCmdlinePopupBorderInput({ fg = white, bg = norm_bg.lighten(10) }),
		NoiceCmdlinePopupBorderLua({ fg = blue, bg = norm_bg.lighten(10) }),
		NoiceCmdlinePopupBorderSearch({ fg = cyan, bg = norm_bg.lighten(10) }),
		NonText({ fg = norm_fg, bg = "NONE" }),
		Normal({ bg = norm_bg, fg = norm_fg }),
		NormalFloat({ Normal }),
		NormalFloatDarker({ Normal }),
		-- NormalFloat({ bg = norm_bg.lighten(15) }),
		-- NormalFloatDarker({ bg = norm_bg.lighten(7) }),
		Number({ fg = red }),
		Operator({ fg = yellow }),
		PanelNormal({ bg = norm_bg.darken(30) }),
		Pmenu({ bg = norm_bg.lighten(10) }),
		PmenuSbar({ bg = norm_bg }),
		PmenuSel({ bg = norm_bg.lighten(1), fg = norm_fg }),
		PmenuThumb({ bg = norm_fg.darken(10) }),
		Question({ fg = green }),
		QuickFixLine({ fg = yellow }),
		Red({ fg = red.lighten(10).hex }),
		Repeat({ fg = cyan }),
		SignColumn({ bg = norm_bg.lighten(10), fg = norm_fg.lighten(10) }),
		Special({ fg = yellow }),
		SpecialComment({ fg = yellow }),
		SpecialKey({ fg = cyan }),
		Statement({ fg = yellow }),
		StatusColSep({ fg = yellow, bg = statusColBG }),
		String({ fg = green }),
		Substitute({ bg = norm_bg.lighten(30) }),
		Tag({ fg = green }),
		TermListCurrent({ fg = norm_bg, bg = yellow }),
		Title({}),
		Todo({ fg = black, bg = yellow.darken(10) }),
		Type({ fg = blue.lighten(20) }),
		Underlined({ gui = "underline" }),
		VertSplit({ bg = norm_bg.darken(9) }),
		Visual({ bg = norm_bg.lighten(20) }),
		WarningMsg({ fg = yellow }),
		White({ fg = white.lighten(10).hex }),
		WildMenu({}),
		WindowPickerStatusLine({ bg = norm_bg.lighten(10), fg = yellow }),
		WindowPickerStatusLineNC({ bg = norm_bg.lighten(10), fg = yellow }),
		Winseparator({ fg = norm_fg, bg = "NONE" }),
		Yellow({ fg = yellow.lighten(10).hex }),

		DiffAdd({ DiffLineAdded }),
		DiffChange({ DiffLineChanged }),
		DiffDelete({ DiffLineDeleted }),
		DiffText({ DiffTextChanged }),
		EndOfBuffer({ Normal }),
		Exception({ Label }),
		IndentBlanklineContextSpaceChar({ IndentBlanklineContextChar }),
		IndentBlanklineSpaceChar({ IndentBlanklineChar }),
		IndentBlanklineSpaceCharBlankline({ IndentBlanklineChar }),
		LspCodeLensSeparator({ Normal }),
		LspReferenceRead({ Normal }),
		LspReferenceText({ Normal }),
		LspReferenceWrite({ Normal }),
		ModeMsg({ Normal }),
		MsgArea({ Normal }),
		MsgSeparator({ Normal }),
		NeoTreeEndOfBuffer(EdgyFileTreeNormal),
		NeoTreeHiddenByName({ NeoTreeDotfile }),
		NeoTreeNormal(EdgyFileTreeNormal),
		NeoTreeNormalNC(EdgyFileTreeNormal),
		NeoTreeTabActive({ BufferCurrent }),
		NeoTreeTabInactive({ BufferInactive }),
		NeoTreeTabSeparatorActive({ BufferCurrent }),
		NeoTreeTabSeparatorInactive({ BufferInactive }),
		NormalNC({ Normal }),
		Search({ IncSearch }),
		SpecialChar({ Special }),
		StorageClass({ Type }),
		Structure({ Type }),
		TabLine({ BufferInactive }),
		TabLineFill({ BufferFill }),
		TabLineSel({ BufferCurrent }),
		Typedef({ Type }),
		StatusLine({ BufferFill }),
		StatusLineNC({ BufferFill }),
		sym("@variable")({ fg = white.darken(10) }),
		sym("@variable.parameter")({ fg = yellow.lighten(10) }),

		-- lCursor({ gui = "reverse" }),
		-- CursorIM     { },
		-- TermCursor({ gui = "reverse" }),
		-- TermCursorNC({ gui = "reverse" }),
		-- VertSplit    { },
		-- MatchParen({ gui = "reverse" }),
		-- SpellBad     { },
		-- SpellCap     { },
		-- SpellLocal   { },
		-- SpellRare    { },
		-- VisualNOS    { },
		-- Whitespace   { },
		-- PreProc({}),
		-- Include({}),
		-- Define({}),
		-- Macro({}),
		-- PreCondit({}),
		-- NeoTreeStatusLine({}),
		-- NeoTreeStatusLineNC({}),
		-- NeoTreeSymbolicLinkTarget({}),
		-- NeoTreeVertSplit({}),
		-- NeoTreeWinSeparator({}),
		-- NeoTreeWindowsHidden({}),
		-- NeoTreeBufferNumber({}),
		-- NeoTreeExpander({}),
		-- NeoTreeFadeText1({}),
		-- NeoTreeFadeText2({}),
		-- NeoTreeFileIcon({}),
		-- NeoTreeFileName({}),
		-- NeoTreeFilterTerm({}),
		-- NeoTreeFloatBorder({}),
		-- NeoTreeFloatTitle({}),
		-- NeoTreeIndentMarker({}),
		-- NeoTreeMessage({}),
	}
end)

-- Return our parsed theme for extension or use elsewhere.
return theme

-- Tree-Sitter syntax groups.
--
-- See :h treesitter-highlight-groups, some groups may not be listed,
-- submit a PR fix to lush-template!
--
-- Tree-Sitter groups are defined with an "@" symbol, which must be
-- specially handled to be valid lua code, we do this via the special
-- sym function. The following are all valid ways to call the sym function,
-- for more details see https://www.lua.org/pil/5.html
--
-- sym("@text.literal")
-- sym('@text.literal')
-- sym"@text.literal"
-- sym'@text.literal'
--
-- For more information see https://github.com/rktjmp/lush.nvim/issues/109

-- sym("@text.literal")({ Comment }),
-- sym("@text.reference")({}),
-- sym("@text.title")({}),
-- sym("@text.uri")({}),
-- sym("@text.underline")({}),
-- sym("@text.todo")({}),
-- sym("@comment")({}),
-- sym("@punctuation")({}),
-- sym("@constant")({}),
-- sym("@constant.builtin")({}),
-- sym("@constant.macro")({}),
-- sym("@define")({}),
-- sym("@macro")({}),
-- sym("@string")({}),
-- sym("@string.escape")({}),
-- sym("@string.special")({}),
-- sym("@character")({}),
-- sym("@character.special")({}),
-- sym("@number")({}),
-- sym("@boolean")({}),
-- sym("@float")({}),
-- sym("@parameter")({}),
-- sym("@method")({}),
-- sym("@field")({}),
-- sym("@property")({}),
-- sym("@constructor")({}),
-- sym("@conditional")({}),
-- sym("@repeat")({}),
-- sym("@label")({}),
-- sym("@operator")({}),
-- sym("@keyword")({}),
-- sym("@exception")({}),
-- sym("@variable")({}),
-- sym("@type")({}),
-- sym("@type.definition")({}),
-- sym("@storageclass")({}),
-- sym("@structure")({}),
-- sym("@namespace")({}),
-- sym("@include")({}),
-- sym("@preproc")({}),
-- sym("@debug")({}),
-- sym("@tag")({}),
