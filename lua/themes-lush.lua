-- Built with,
--
--        ,gggg,
--       d8" "8I                         ,dPYb,
--       88  ,dP                         IP'`Yb
--    8888888P"                          I8  8I
--       88                              I8  8'
--       88        gg      gg    ,g,     I8 dPgg,
--  ,aa,_88        I8      8I   ,8'8,    I8dP" "8I
-- dP" "88P        I8,    ,8I  ,8'  Yb   I8P    I8
-- Yb,_,d88b,,_   ,d8b,  ,d8b,,8'_   8) ,d8     I8,
--  "Y8P"  "Y888888P'"Y88P"`Y8P' "YY8P8P88P     `Y8
--

-- This is a starter colorscheme for use with Lush,
-- for usage guides, see :h lush or :LushRunTutorial

--
-- Note: Because this is a lua file, vim will append it to the runtime,
--       which means you can require(...) it in other lua code (this is useful),
--       but you should also take care not to conflict with other libraries.
--
--       (This is a lua quirk, as it has somewhat poor support for namespacing.)
--
--       Basically, name your file,
--
--       "super_theme/lua/lush_theme/super_theme_dark.lua",
--
--       not,
--
--       "super_theme/lua/dark.lua".
--
--       With that caveat out of the way...
--

-- Enable lush.ify on this file, run:
--
--  `:Lushify`
--
--  or
--
--  `:lua require('lush').ify()`

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

-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
	local sym = injected_functions.sym
	return {
		--
		-- See :h highlight-groups
		--
		Normal({ bg = norm_bg, fg = norm_fg }), -- Normal text
		NormalFloat({ Normal }), -- Normal text in floating windows.
		NormalNC({ Normal }), -- normal text in non-current windows
		ColorColumn({ bg = norm_bg.lighten(10) }), -- Columns set with 'colorcolumn'
		Conceal({ fg = yellow, bg = norm_bg }), -- Placeholder characters substituted for concealed text (see 'conceallevel')
		Cursor({ gui = "reverse" }), -- Character under the cursor
		lCursor({ gui = "reverse" }), -- Character under the cursor when |language-mapping| is used (see 'guicursor')
		-- CursorIM     { }, -- Like Cursor, but used when in IME mode |CursorIM|
		CursorColumn({ bg = norm_bg.lighten(10) }), -- Screen-column at the cursor, when 'cursorcolumn' is set.
		CursorLine({ bg = norm_bg.lighten(10) }), -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
		Directory({ fg = blue }), -- Directory names (and other special names in listings)
		EndOfBuffer({ Normal }), -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
		-- TermCursor({ gui = "reverse" }), -- Cursor in a focused terminal
		-- TermCursorNC({ gui = "reverse" }), -- Cursor in an unfocused terminal
		ErrorMsg({ fg = red }), -- Error messages on the command line
		-- VertSplit    { }, -- Column separating vertically split windows
		Folded({ bg = norm_bg.lighten(15), fg = norm_fg }), -- Line used for closed folds
		FoldColumn({ bg = norm_bg.lighten(10), fg = norm_fg.lighten(10) }), -- 'foldcolumn'
		SignColumn({ bg = norm_bg.lighten(10), fg = norm_fg.lighten(10) }), -- Column where |signs| are displayed
		IncSearch({ bg = norm_bg.lighten(30) }), -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
		Substitute({ bg = norm_bg.lighten(30) }), -- |:substitute| replacement text highlighting
		LineNr({ bg = norm_bg.lighten(10), fg = norm_fg.darken(20) }), -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
		CursorLineNr({ bg = norm_bg.lighten(10), fg = norm_fg.lighten(30) }), -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
		MatchParen({ gui = "reverse" }), -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
		ModeMsg({ Normal }), -- 'showmode' message (e.g., "-- INSERT -- ")
		MsgArea({ Normal }), -- Area for messages and cmdline
		MsgSeparator({ Normal }), -- Separator for scrolled messages, `msgsep` flag of 'display'
		MoreMsg({ fg = green }), -- |more-prompt|
		NonText({ Normal }), -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
		Pmenu({ bg = norm_bg.lighten(10) }), -- Popup menu: Normal item.
		PmenuSel({ bg = norm_bg.lighten(1), fg = norm_fg }), -- Popup menu: Selected item.
		PmenuSbar({ bg = norm_bg }), -- Popup menu: Scrollbar.
		PmenuThumb({ bg = norm_fg.darken(10) }), -- Popup menu: Thumb of the scrollbar.
		Question({ fg = green }), -- |hit-enter| prompt and yes/no questions
		QuickFixLine({ fg = yellow }), -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
		Search({ IncSearch }), -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
		SpecialKey({ fg = cyan }), -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
		-- SpellBad     { }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
		-- SpellCap     { }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
		-- SpellLocal   { }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
		-- SpellRare    { }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
		-- StatusLine   { }, -- Status line of current window
		-- StatusLineNC { }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
		Title({}), -- Titles for output from ":set all", ":autocmd" etc.
		Visual({ bg = norm_bg.lighten(25) }), -- Visual mode selection
		-- VisualNOS    { }, -- Visual mode selection when vim is "Not Owning the Selection".
		WarningMsg({ fg = yellow }), -- Warning messages
		-- Whitespace   { }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
		Winseparator({ fg = norm_fg, bg = "NONE" }), -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
		WildMenu({}), -- Current match in 'wildmenu' completion

		-- Common vim syntax groups used for all kinds of code and markup.
		-- Commented-out groups should chain up to their preferred (*) group
		-- by default.
		--
		-- See :h group-name
		--
		-- Uncomment and edit if you want more specific syntax highlighting.

		Comment({ fg = norm_fg.darken(30) }), -- Any comment

		Constant({ fg = blue }), -- (*) Any constant
		String({ fg = green }), --   A string constant: "this is a string"
		Character({ fg = blue }), --   A character constant: 'c', '\n'
		Number({ fg = red }), --   A number constant: 234, 0xff
		Boolean({ fg = magenta }), --   A boolean constant: TRUE, false
		Float({ fg = red }), --   A floating point constant: 2.3e10

		Identifier({ fg = magenta.saturate(20).lighten(30) }), -- (*) Any variable name
		Function({ fg = blue.lighten(20) }), --   Function name (also: methods for classes)

		Statement({ fg = yellow }), -- (*) Any statement
		Conditional({ fg = blue }), --   if, then, else, endif, switch, etc.
		Repeat({ fg = cyan }), --   for, do, while, etc.
		Label({ fg = green }), --   case, default, etc.
		Operator({ fg = yellow }), --   "sizeof", "+", "*", etc.
		Keyword({ fg = red.lighten(10).desaturate(30) }), --   any other keyword
		Exception({ Label }), --   try, catch, throw

		-- PreProc({}), -- (*) Generic Preprocessor
		-- Include({}), --   Preprocessor #include
		-- Define({}), --   Preprocessor #define
		-- Macro({}), --   Same as Define
		-- PreCondit({}), --   Preprocessor #if, #else, #endif, etc.

		Type({ fg = blue.lighten(20) }), -- (*) int, long, char, etc.
		StorageClass({ Type }), --   static, register, volatile, etc.
		Structure({ Type }), --   struct, union, enum, etc.
		Typedef({ Type }), --   A typedef

		Special({ fg = yellow }), -- (*) Any special symbol
		SpecialChar({ Special }), --   Special character in a constant
		Tag({ fg = green }), --   You can use CTRL-] on this
		Delimiter({ fg = blue }), --   Character that needs attention
		SpecialComment({ fg = yellow }), --   Special things inside a comment (e.g. '\n')
		Debug({}), --   Debugging statements

		Underlined({ gui = "underline" }), -- Text that stands out, HTML links
		Ignore({}), -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
		Error({}), -- Any erroneous construct
		Todo({ fg = black, bg = yellow.darken(10) }), -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

		-- These groups are for the native LSP client and diagnostic system. Some
		-- other LSP clients may use these groups, or use their own. Consult your
		-- LSP client's documentation.

		-- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
		--
		LspReferenceText({ Normal }), -- Used for highlighting "text" references
		LspReferenceRead({ Normal }), -- Used for highlighting "read" references
		LspReferenceWrite({ Normal }), -- Used for highlighting "write" references
		LspCodeLens({ fg = diagnostic_error }), -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
		LspCodeLensSeparator({ Normal }), -- Used to color the seperator between two or more code lens.
		LspSignatureActiveParameter({ bg = norm_bg.lighten(10) }), -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

		-- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
		--
		DiagnosticError({ fg = diagnostic_error }), -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticWarn({ fg = diagnostic_warning }), -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticInfo({ fg = diagnostic_info }), -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticHint({ fg = diagnostic_hint }), -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticVirtualTextError({ fg = diagnostic_error }), -- Used for "Error" diagnostic virtual text.
		DiagnosticVirtualTextWarn({ fg = diagnostic_warning }), -- Used for "Warn" diagnostic virtual text.
		DiagnosticVirtualTextInfo({ fg = diagnostic_info }), -- Used for "Info" diagnostic virtual text.
		DiagnosticVirtualTextHint({ fg = diagnostic_hint }), -- Used for "Hint" diagnostic virtual text.
		DiagnosticUnderlineError({ fg = diagnostic_error }), -- Used to underline "Error" diagnostics.
		DiagnosticUnderlineWarn({ fg = diagnostic_warning }), -- Used to underline "Warn" diagnostics.
		DiagnosticUnderlineInfo({ fg = diagnostic_info }), -- Used to underline "Info" diagnostics.
		DiagnosticUnderlineHint({ fg = diagnostic_hint }), -- Used to underline "Hint" diagnostics.
		DiagnosticFloatingError({ fg = diagnostic_error }), -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
		DiagnosticFloatingWarn({ fg = diagnostic_warning }), -- Used to color "Warn" diagnostic messages in diagnostics float.
		DiagnosticFloatingInfo({ fg = diagnostic_info }), -- Used to color "Info" diagnostic messages in diagnostics float.
		DiagnosticFloatingHint({ fg = diagnostic_hint }), -- Used to color "Hint" diagnostic messages in diagnostics float.
		DiagnosticSignError({ fg = diagnostic_error, bg = statusColBG }), -- Used for "Error" signs in sign column.
		DiagnosticSignWarn({ fg = diagnostic_warning, bg = statusColBG }), -- Used for "Warn" signs in sign column.
		DiagnosticSignInfo({ fg = diagnostic_info, bg = statusColBG }), -- Used for "Info" signs in sign column.
		DiagnosticSignHint({ fg = diagnostic_hint, bg = statusColBG }), -- Used for "Hint" signs in sign column.

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

		-- sym("@text.literal")({ Comment }), -- Comment
		-- sym("@text.reference")({}), -- Identifier
		-- sym("@text.title")({}), -- Title
		-- sym("@text.uri")({}), -- Underlined
		-- sym("@text.underline")({}), -- Underlined
		-- sym("@text.todo")({}), -- Todo
		-- sym("@comment")({}), -- Comment
		-- sym("@punctuation")({}), -- Delimiter
		-- sym("@constant")({}), -- Constant
		-- sym("@constant.builtin")({}), -- Special
		-- sym("@constant.macro")({}), -- Define
		-- sym("@define")({}), -- Define
		-- sym("@macro")({}), -- Macro
		-- sym("@string")({}), -- String
		-- sym("@string.escape")({}), -- SpecialChar
		-- sym("@string.special")({}), -- SpecialChar
		-- sym("@character")({}), -- Character
		-- sym("@character.special")({}), -- SpecialChar
		-- sym("@number")({}), -- Number
		-- sym("@boolean")({}), -- Boolean
		-- sym("@float")({}), -- Float
		-- sym("@function")({}), -- Function
		-- sym("@function.builtin")({}), -- Special
		-- sym("@function.macro")({}), -- Macro
		-- sym("@parameter")({}), -- Identifier
		-- sym("@method")({}), -- Function
		-- sym("@field")({}), -- Identifier
		-- sym("@property")({}), -- Identifier
		-- sym("@constructor")({}), -- Special
		-- sym("@conditional")({}), -- Conditional
		-- sym("@repeat")({}), -- Repeat
		-- sym("@label")({}), -- Label
		-- sym("@operator")({}), -- Operator
		-- sym("@keyword")({}), -- Keyword
		-- sym("@exception")({}), -- Exception
		-- sym("@variable")({}), -- Identifier
		-- sym("@type")({}), -- Type
		-- sym("@type.definition")({}), -- Typedef
		-- sym("@storageclass")({}), -- StorageClass
		-- sym("@structure")({}), -- Structure
		-- sym("@namespace")({}), -- Identifier
		-- sym("@include")({}), -- Include
		-- sym("@preproc")({}), -- PreProc
		-- sym("@debug")({}), -- Debug
		-- sym("@tag")({}), -- Tag

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

		TabLine({ BufferInactive }), -- Tab pages line, not active tab page label
		TabLineFill({ BufferFill }), -- Tab pages line, where there are no labels
		TabLineSel({ BufferCurrent }), -- Tab pages line, active tab page label
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

		-- NeoTree
		NeoTreeDimText({ fg = gray.lighten(20) }),
		-- NeoTreeBufferNumber({}),
		NeoTreeCursorLine({ bg = norm_bg.darken(9) }),
		NeoTreeDirectoryIcon({ Directory }),
		NeoTreeDirectoryName({ Directory }),
		NeoTreeDotfile({ fg = gray.lighten(20) }),
		NeoTreeEndOfBuffer({ bg = norm_bg.lighten(10) }),
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
		NeoTreeNormal({ bg = norm_bg.lighten(10) }),
		NeoTreeNormalNC({ bg = norm_bg.lighten(10) }),
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
		-- NeoTreeTitleBar({}),
		-- NeoTreeVertSplit({}),
		-- NeoTreeWinSeparator({}),
		-- NeoTreeWindowsHidden({}),

		-- colorful-winsep
		--
		NvimSeparator({ fg = yellow, bg = norm_bg }),

		StatusColSep({ fg = yellow, bg = statusColBG }),

		TermListCurrent({ fg = norm_bg, bg = yellow }),
	}
end)

lush(theme)
-- Return our parsed theme for extension or use elsewhere.
return theme
