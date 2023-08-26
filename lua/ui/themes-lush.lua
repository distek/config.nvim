local lush = require("lush")
local hsl = lush.hsl

local lightenAmount = 1

local norm_fg = hsl(241, 33, 78).lighten(lightenAmount)
local norm_bg = hsl(215, 15, 10).lighten(lightenAmount)

local black = hsl(215, 15, 25)
local red = hsl(0, 30, 50)
local green = hsl(74, 45, 51)
local yellow = hsl(49, 55, 52)
local blue = hsl(204, 41, 53)
local magenta = hsl(276, 28, 52)
local cyan = hsl(162, 30, 50)
local white = hsl(215, 15, 81)

local gray = hsl(215, 15, 26)

local diagnostic_error = hsl(8, 56, 54).lighten(lightenAmount)
local diagnostic_warning = hsl(56, 56, 54).lighten(lightenAmount)
local diagnostic_info = hsl(188, 44, 43).lighten(lightenAmount)
local diagnostic_hint = hsl(258, 56, 77).lighten(lightenAmount)

local git_green = hsl(116, 31, 37).lighten(lightenAmount)
local git_blue = hsl(183, 31, 37).lighten(lightenAmount)
local git_red = hsl(0, 44, 37).lighten(lightenAmount)

local statusColBG = norm_bg.lighten(10)

vim.g.terminal_color_0 = black.lighten(10).hex
vim.g.terminal_color_1 = red.lighten(10).hex
vim.g.terminal_color_2 = green.lighten(10).hex
vim.g.terminal_color_3 = yellow.lighten(10).hex
vim.g.terminal_color_4 = blue.lighten(10).hex
vim.g.terminal_color_5 = magenta.lighten(10).hex
vim.g.terminal_color_6 = cyan.lighten(10).hex
vim.g.terminal_color_7 = white.lighten(10).hex
vim.g.terminal_color_8 = black.lighten(20).hex
vim.g.terminal_color_9 = red.lighten(20).hex
vim.g.terminal_color_10 = green.lighten(20).hex
vim.g.terminal_color_11 = yellow.lighten(20).hex
vim.g.terminal_color_12 = blue.lighten(20).hex
vim.g.terminal_color_13 = magenta.lighten(20).hex
vim.g.terminal_color_14 = cyan.lighten(20).hex
vim.g.terminal_color_15 = white.lighten(20).hex

---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
	local ret = {
		Blend100({ bg = "NONE" }),

		Black({ fg = black.lighten(10).hex }),
		Red({ fg = red.lighten(10).hex }),
		Green({ fg = green.lighten(10).hex }),
		Yellow({ fg = yellow.lighten(10).hex }),
		Blue({ fg = blue.lighten(10).hex }),
		Magenta({ fg = magenta.lighten(10).hex }),
		Cyan({ fg = cyan.lighten(10).hex }),
		White({ fg = white.lighten(10).hex }),
		LightBlack({ fg = black.lighten(20).hex }),
		LightRed({ fg = red.lighten(20).hex }),
		LightGreen({ fg = green.lighten(20).hex }),
		LightYellow({ fg = yellow.lighten(20).hex }),
		LightBlue({ fg = blue.lighten(20).hex }),
		LightMagenta({ fg = magenta.lighten(20).hex }),
		LightCyan({ fg = cyan.lighten(20).hex }),
		LightWhite({ fg = white.lighten(20).hex }),
		Normal({ bg = norm_bg, fg = norm_fg }),
		NormalFloat({ Normal }),
		FloatShadow({ blend = 15, bg = norm_bg.darken(20) }),
		NormalNC({ Normal }),
		ColorColumn({ bg = norm_bg.lighten(10) }),
		Conceal({ fg = yellow, bg = norm_bg }),
		Cursor({ fg = norm_bg, bg = norm_fg }),
		-- lCursor({ gui = "reverse" }),
		-- CursorIM     { },
		CursorColumn({ bg = norm_bg.lighten(10) }),
		CursorLine({ bg = norm_bg.lighten(10) }),
		Directory({ fg = blue }),
		EndOfBuffer({ Normal }),
		-- TermCursor({ gui = "reverse" }),
		-- TermCursorNC({ gui = "reverse" }),
		ErrorMsg({ fg = red }),
		-- VertSplit    { },
		Folded({ bg = norm_bg.lighten(15), fg = norm_fg }),
		FoldColumn({ bg = norm_bg.lighten(10), fg = norm_fg.lighten(10) }),
		SignColumn({ bg = norm_bg.lighten(10), fg = norm_fg.lighten(10) }),
		IncSearch({ bg = norm_bg.lighten(30) }),
		Substitute({ bg = norm_bg.lighten(30) }),
		LineNr({ bg = norm_bg.lighten(10), fg = norm_fg.darken(20) }),
		CursorLineNr({ bg = norm_bg.lighten(10), fg = norm_fg.lighten(30) }),
		-- MatchParen({ gui = "reverse" }),
		ModeMsg({ Normal }),
		MsgArea({ Normal }),
		MsgSeparator({ Normal }),
		MoreMsg({ fg = green }),
		NonText({ Normal }),
		Pmenu({ bg = norm_bg.lighten(10) }),
		PmenuSel({ bg = norm_bg.lighten(1), fg = norm_fg }),
		PmenuSbar({ bg = norm_bg }),
		PmenuThumb({ bg = norm_fg.darken(10) }),
		Question({ fg = green }),
		QuickFixLine({ fg = yellow }),
		Search({ IncSearch }),
		SpecialKey({ fg = cyan }),
		-- SpellBad     { },
		-- SpellCap     { },
		-- SpellLocal   { },
		-- SpellRare    { },
		-- StatusLine   { },
		-- StatusLineNC { },
		Title({}),
		Visual({ bg = norm_bg.lighten(25) }),
		-- VisualNOS    { },
		WarningMsg({ fg = yellow }),
		-- Whitespace   { },
		Winseparator({ fg = norm_fg, bg = "NONE" }),
		WildMenu({}),

		Comment({ fg = norm_fg.darken(30) }),

		Constant({ fg = blue }),
		String({ fg = green }),
		Character({ fg = blue }),
		Number({ fg = red }),
		Boolean({ fg = magenta }),
		Float({ fg = red }),

		Identifier({ fg = magenta.saturate(20).lighten(30) }),
		Function({ fg = blue.lighten(20) }),

		Statement({ fg = yellow }),
		Conditional({ fg = blue }),
		Repeat({ fg = cyan }),
		Label({ fg = green }),
		Operator({ fg = yellow }),
		Keyword({ fg = red.lighten(10).desaturate(30) }),
		Exception({ Label }),

		-- PreProc({}),
		-- Include({}),
		-- Define({}),
		-- Macro({}),
		-- PreCondit({}),

		Type({ fg = blue.lighten(20) }),
		StorageClass({ Type }),
		Structure({ Type }),
		Typedef({ Type }),

		Special({ fg = yellow }),
		SpecialChar({ Special }),
		Tag({ fg = green }),
		Delimiter({ fg = blue }),
		SpecialComment({ fg = yellow }),
		Debug({}),

		Underlined({ gui = "underline" }),
		Ignore({}),
		Error({}),
		Todo({ fg = black, bg = yellow.darken(10) }),

		-- These groups are for the native LSP client and diagnostic system. Some
		-- other LSP clients may use these groups, or use their own. Consult your
		-- LSP client's documentation.

		-- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
		--
		LspReferenceText({ Normal }),
		LspReferenceRead({ Normal }),
		LspReferenceWrite({ Normal }),
		LspCodeLens({ fg = diagnostic_error }),
		LspCodeLensSeparator({ Normal }),
		LspSignatureActiveParameter({ bg = norm_bg.lighten(10) }),

		-- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
		--
		DiagnosticError({ fg = diagnostic_error }),
		DiagnosticWarn({ fg = diagnostic_warning }),
		DiagnosticInfo({ fg = diagnostic_info }),
		DiagnosticHint({ fg = diagnostic_hint }),
		DiagnosticVirtualTextError({ fg = diagnostic_error }),
		DiagnosticVirtualTextWarn({ fg = diagnostic_warning }),
		DiagnosticVirtualTextInfo({ fg = diagnostic_info }),
		DiagnosticVirtualTextHint({ fg = diagnostic_hint }),
		DiagnosticUnderlineError({ fg = diagnostic_error }),
		DiagnosticUnderlineWarn({ fg = diagnostic_warning }),
		DiagnosticUnderlineInfo({ fg = diagnostic_info }),
		DiagnosticUnderlineHint({ fg = diagnostic_hint }),
		DiagnosticFloatingError({ fg = diagnostic_error }),
		DiagnosticFloatingWarn({ fg = diagnostic_warning }),
		DiagnosticFloatingInfo({ fg = diagnostic_info }),
		DiagnosticFloatingHint({ fg = diagnostic_hint }),
		DiagnosticSignError({ fg = diagnostic_error, bg = statusColBG }),
		DiagnosticSignWarn({ fg = diagnostic_warning, bg = statusColBG }),
		DiagnosticSignInfo({ fg = diagnostic_info, bg = statusColBG }),
		DiagnosticSignHint({ fg = diagnostic_hint, bg = statusColBG }),

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
		-- sym("@function")({}),
		-- sym("@function.builtin")({}),
		-- sym("@function.macro")({}),
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

		FNoteNormal({ bg = norm_bg.darken(8) }),
		FNoteEndOfBuffer({ bg = norm_bg.darken(8) }),
		FNoteNormalNC({ bg = norm_bg.darken(8) }),
		FNoteCursorLine({ bg = norm_bg.darken(9) }),

		VertSplit({ bg = norm_bg.darken(9) }),

		-- Barbar
		BufferOffset({ fg = magenta.lighten(30).saturate(30), bg = black }),

		BufferCurrent({ fg = white, bg = norm_bg }),
		BufferCurrentIndex({ fg = white, bg = norm_bg }),
		BufferCurrentSign({ fg = white, bg = norm_bg }),
		BufferCurrentMod({ fg = white, bg = norm_bg }),
		BufferCurrentTarget({ fg = white, bg = norm_bg }),

		BufferVisible({ fg = gray.lighten(50), bg = black.lighten(10) }),
		BufferVisibleIndex({ fg = gray.lighten(50), bg = black.lighten(10) }),
		BufferVisibleSign({ fg = gray.lighten(50), bg = black.lighten(10) }),
		BufferVisibleMod({ fg = gray.lighten(50), bg = black.lighten(10) }),
		BufferVisibleTarget({ fg = gray.lighten(50), bg = black.lighten(10) }),

		BufferInactive({ fg = gray.lighten(40), bg = black }),
		BufferInactiveIndex({ fg = gray.lighten(40), bg = black }),
		BufferInactiveSign({ fg = gray.lighten(40), bg = black }),
		BufferInactiveMod({ fg = gray.lighten(40), bg = black }),
		BufferInactiveTarget({ fg = gray.lighten(40), bg = black }),

		BufferFill({ bg = norm_bg.lighten(10) }),

		TabLine({ BufferInactive }),
		TabLineFill({ BufferFill }),
		TabLineSel({ BufferCurrent }),
		-- indent-blankline
		IndentBlanklineChar({ fg = norm_fg.darken(10) }),
		IndentBlanklineSpaceChar({ IndentBlanklineChar }),
		IndentBlanklineSpaceCharBlankline({ IndentBlanklineChar }),
		IndentBlanklineContextChar({ fg = blue }),
		IndentBlanklineContextSpaceChar({ IndentBlanklineContextChar }),
		IndentBlanklineContextStart({ gui = "undercurl", guisp = blue }),

		-- gitsigns
		GitSignsAdd({ fg = green, bg = statusColBG }),
		GitSignsChange({ fg = green, bg = statusColBG }),
		GitSignsChangedelete({ fg = yellow, bg = statusColBG }),
		GitSignsDelete({ fg = red, bg = statusColBG }),
		GitSignsTopdelete({ fg = red, bg = statusColBG }),
		GitSignsUntracked({ fg = gray, bg = statusColBG }),

		DiffTextAdded({ bg = git_green }),
		DiffTextDeleted({ bg = git_red }),
		DiffTextChanged({ bg = git_blue }),
		DiffLineAdded({ bg = git_green.darken(10) }),
		DiffLineDeleted({ bg = git_red.darken(10) }),
		DiffLineChanged({ bg = git_blue.darken(10) }),
		DiffAdd({ DiffLineAdded }),
		DiffDelete({ DiffLineDeleted }),
		DiffChange({ DiffLineChanged }),
		DiffText({ DiffTextChanged }),

		-- edgy
		EdgyWinBar({ bg = norm_bg.darken(100) }),
		EdgyTermNormal({ bg = norm_bg.darken(30) }),
		EdgyTermListNormal({ bg = norm_bg.lighten(5) }),
		EdgyBuffersNormal({ bg = norm_bg.lighten(25) }),
		EdgyBuffersNormalNC({ bg = norm_bg.lighten(25) }),
		EdgyFileTreeNormal({ bg = norm_bg.lighten(5) }),
		EdgyHelpNormal({ bg = norm_bg.lighten(15) }),
		EdgyQuickfixNormal({ bg = norm_bg.darken(20) }),

		-- NeoTree
		NeoTreeDimText({ fg = gray.lighten(20) }),
		-- NeoTreeBufferNumber({}),
		NeoTreeCursorLine({ bg = norm_bg.darken(9) }),
		NeoTreeDirectoryIcon({ Directory }),
		NeoTreeDirectoryName({ Directory }),
		NeoTreeDotfile({ fg = gray.lighten(20) }),
		NeoTreeEndOfBuffer(EdgyFileTreeNormal),
		-- NeoTreeExpander({}),
		-- NeoTreeFadeText1({}),
		-- NeoTreeFadeText2({}),
		-- NeoTreeFileIcon({}),
		-- NeoTreeFileName({}),
		NeoTreeFileNameOpened({ gui = "bold" }),
		-- NeoTreeFilterTerm({}),
		-- NeoTreeFloatBorder({}),
		-- NeoTreeFloatTitle({}),
		-- NeoTreeGitConflict({}),
		-- NeoTreeGitIgnored({}),
		NeoTreeGitUnstaged({ fg = blue }),
		NeoTreeGitUntracked({ fg = yellow }),
		NeoTreeHiddenByName({ NeoTreeDotfile }),
		-- NeoTreeIndentMarker({}),
		-- NeoTreeMessage({}),
		NeoTreeModified({ fg = blue }),
		NeoTreeNormal(EdgyFileTreeNormal),
		NeoTreeNormalNC(EdgyFileTreeNormal),
		NeoTreeRootName({ fg = white }),
		NeoTreeRootName_68({ fg = white.darken(30) }),
		NeoTreeRootName_60({ fg = white.darken(50) }),
		NeoTreeRootName_35({ fg = white.darken(60) }),
		-- NeoTreeStatusLine({}),
		-- NeoTreeStatusLineNC({}),
		-- NeoTreeSymbolicLinkTarget({}),
		NeoTreeTabActive({ BufferCurrent }),
		NeoTreeTabInactive({ BufferInactive }),
		NeoTreeTabSeparatorActive({ BufferCurrent }),
		NeoTreeTabSeparatorInactive({ BufferInactive }),
		NeoTreeTitleBar({}),
		-- NeoTreeVertSplit({}),
		-- NeoTreeWinSeparator({}),
		-- NeoTreeWindowsHidden({}),

		-- colorful-winsep
		--
		NvimSeparator({ fg = yellow, bg = norm_bg }),

		StatusColSep({ fg = yellow, bg = statusColBG }),

		TermListCurrent({ fg = norm_bg, bg = yellow }),

		NoiceCmdLine({ bg = norm_bg.lighten(15) }),
		NoiceCmdlinePopupBorderCalculator({ fg = yellow, bg = norm_bg.lighten(10) }),
		NoiceCmdlinePopupBorderCmdline({ fg = blue, bg = norm_bg.lighten(10) }),
		NoiceCmdlinePopupBorderFilter({ fg = red, bg = norm_bg.lighten(10) }),
		NoiceCmdlinePopupBorderHelp({ fg = green, bg = norm_bg.lighten(10) }),
		NoiceCmdlinePopupBorderIncRename({ fg = magenta, bg = norm_bg.lighten(10) }),
		NoiceCmdlinePopupBorderInput({ fg = white, bg = norm_bg.lighten(10) }),
		NoiceCmdlinePopupBorderLua({ fg = blue, bg = norm_bg.lighten(10) }),
		NoiceCmdlinePopupBorderSearch({ fg = cyan, bg = norm_bg.lighten(10) }),

		CmpItemAbbrMatch({ fg = blue }),

		DapBreakpoint({ fg = red, bg = statusColBG }),
		DapLogPoint({ fg = yellow, bg = statusColBG }),
		DapStopped({ fg = blue, bg = statusColBG }),
		HLChunkIndicator({ fg = blue.darken(20) }),
	}

	return ret
end)

-- Return our parsed theme for extension or use elsewhere.
return theme
