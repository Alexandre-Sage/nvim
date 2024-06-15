-- TelescopeNormal: The normal text in the Telescope window.
-- TelescopeBorder: The border of the Telescope window.
-- TelescopePromptBorder: The border of the prompt area.
-- TelescopeResultsBorder: The border of the results area.
-- TelescopePreviewBorder: The border of the preview area.
-- TelescopeMatching: The matched characters in the results.
-- TelescopePromptPrefix: The prefix in the prompt area.
-- TelescopeSelection: The selected item in the results.
-- TelescopeSelectionCaret: The caret for the selected item.
-- TelescopeMultiSelection: The selected item in multi-selection mode.
-- TelescopeTitle: The title of the Telescope window.
-- TelescopePromptTitle: The title of the prompt area.
-- TelescopeResultsTitle: The title of the results area.
-- TelescopePreviewTitle: The title of the preview area.
-- TelescopePreviewNormal: The normal text in the preview area.
-- TelescopePreviewLine: The current line in the preview area.
-- TelescopePreviewMatch: The matched characters in the preview area.
-- TelescopePromptCounter:
-- NeogitNotificationInfo: Highlight group for informational notifications.
-- NeogitNotificationWarning: Highlight group for warning notifications.
-- NeogitNotificationError: Highlight group for error notifications.
-- NeogitDiffAdd: Highlight group for added lines in diffs.
-- NeogitDiffDelete: Highlight group for deleted lines in diffs.
-- NeogitDiffContext: Highlight group for unchanged lines in diffs.
-- NeogitHunkHeader: Highlight group for the header of a diff hunk.
-- NeogitHunkHeaderHighlight: Highlight group for the highlighted hunk header.
-- NeogitDiffAddHighlight: Highlight group for highlighted added lines in diffs.
-- NeogitDiffDeleteHighlight: Highlight group for highlighted deleted lines in diffs.
local lush = require("lush")

local hsl = lush.hsl
local blue1 = hsl("#00f6ff")
local blue2 = hsl("#02bbfb")
local purple = hsl("#ff007b")
local surf_green = hsl("#02fbbd")
local light_grey = hsl("#5a6e72")
local yellow = hsl("#eeff00")
local orange = hsl("#fc7f03")
local grey_white = hsl("#829996")
local error_red = hsl("#f7022b")
local warning_yellow = hsl("#758000")

local float_border_fg = "#454545"
local selection_config = { bg = yellow.lighten(-50), fg = surf_green }
local blue1_fg = { fg = blue1 }
local blue2_fg = { fg = blue2 }
local grey_fg = { fg = light_grey }
local purple_fg = { fg = purple }
local surf_green_fg = { fg = surf_green }
local orange_fg = { fg = orange }
local yellow_fg = { fg = yellow }
local grey_white_fg = { fg = grey_white }
local error_red_fg = { fg = error_red }
local warning_config = { fg = warning_yellow, bg = surf_green.lighten(-80) }
local error_config = { fg = purple, bg = surf_green.lighten(-80) }
local cursor_line_config = { bg = purple.lighten(-80) }
-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
---@diagnostic disable: undefined-global
-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
	local sym = injected_functions.sym
	return {
		NeogitHunkHeaderHighlight(purple_fg),
		LineNr(grey_white_fg),
		LineNrAbove(surf_green_fg),
		LineNrBelow(blue1_fg),
		CursorLineNr(yellow_fg),
		Normal(blue1_fg),
		FloatTitle(purple_fg), -- See :h highlight-groups
		TelescopeBorder(purple_fg),
		--
		-- ColorColumn(surf_green_fg), -- Columns set with 'colorcolumn'
		-- Conceal        (), -- Placeholder characters substituted for concealed text (see 'conceallevel')
		Cursor(surf_green_fg),                      -- Character under the cursor
		CurSearch({ bg = yellow.lighten(-50), fg = surf_green }), -- Highlighting a search pattern under the cursor (see 'hlsearch')
		-- lCursor        (), -- Character under the cursor when |language-mapping| is used (see 'guicursor')
		-- CursorIM       (), -- Like Cursor, but used when in IME mode |CursorIM|
		-- CursorColumn   (), -- Screen-column at the cursor, when 'cursorcolumn' is set.
		CursorLine(cursor_line_config), -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
		Directory(yellow_fg),       -- Directory names (and other special names in listings)
		DiffAdd({ bg = blue2.lighten(-60) }), -- Diff mode: Added line |diff.txt|
		DiffChange({ bg = blue2.lighten(-60) }), -- Diff mode: Changed line |diff.txt|
		DiffDelete({ bg = purple.lighten(-60) }), -- Diff mode: Deleted line |diff.txt|
		DiffText({ bg = blue1.lighten(-50) }), -- Diff mode: Changed text within a changed line |diff.txt|
		-- EndOfBuffer    (), -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
		-- TermCursor     (), -- Cursor in a focused terminal
		-- TermCursorNC   (), -- Cursor in an unfocused terminal
		-- ErrorMsg       (), -- Error messages on the command line
		-- VertSplit      (), -- Column separating vertically split windows
		-- Folded         (), -- Line used for closed folds
		-- FoldColumn     (), -- 'foldcolumn'
		-- SignColumn     (), -- Column where |signs| are displayed
		-- IncSearch      (), -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
		-- Substitute     (), -- |:substitute| replacement text highlighting
		-- CursorLineFold (), -- Like FoldColumn when 'cursorline' is set for the cursor line
		-- CursorLineSign (), -- Like SignColumn when 'cursorline' is set for the cursor line
		-- MatchParen     (), -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
		ModeMsg(purple_fg), -- 'showmode' message (e.g., "-- INSERT -- ")
		-- MsgArea        (), -- Area for messages and cmdline
		-- MsgSeparator   (), -- Separator for scrolled messages, `msgsep` flag of 'display'
		-- MoreMsg        (), -- |more-prompt|
		-- NonText        (), -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
		-- Normal         (), -- Normal text
		NormalFloat(surf_green_fg), -- Normal text in floating windows.
		FloatBorder(purple_fg), -- Border of floating windows.
		-- FloatTitle     (), -- Title of floating windows.
		-- NormalNC       (), -- normal text in non-current windows
		Pmenu(purple_fg), -- Popup menu: Normal item.
		PmenuSel(selection_config), -- Popup menu: Selected item.
		PmenuKind(blue2_fg), -- Popup menu: Normal item "kind"
		PmenuKindSel(blue2_fg), -- Popup menu: Selected item "kind"
		PmenuExtra(surf_green_fg), -- Popup menu: Normal item "extra text"
		-- PmenuExtraSel  (), -- Popup menu: Selected item "extra text"
		-- PmenuSbar      (), -- Popup menu: Scrollbar.
		-- PmenuThumb     (), -- Popup menu: Thumb of the scrollbar.
		-- Question       (), -- |hit-enter| prompt and yes/no questions
		-- QuickFixLine   (), -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
		-- Search         (), -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
		-- SpecialKey     (), -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
		-- SpellBad       (), -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
		-- SpellCap       (), -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
		-- SpellLocal     (), -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
		-- SpellRare      (), -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
		StatusLine(purple_fg), -- Status line of current window
		-- StatusLineNC   (), -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
		TabLine(surf_green_fg), -- Tab pages line, not active tab page label
		-- TabLineFill    (), -- Tab pages line, where there are no labels
		TabLineSel(purple_fg), -- Tab pages line, active tab page label
		-- Title          (), -- Titles for output from ":set all", ":autocmd" etc.
		Visual(selection_config), -- Visual mode selection
		-- VisualNOS      (), -- Visual mode selection when vim is "Not Owning the Selection".
		WarningMsg(warning_config), -- Warning messages
		-- Whitespace     (), -- "nbsp", "space", "tab" and "trail" in 'listchars'
		-- Winseparator   (), -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
		WildMenu(yellow_fg), -- Current match in 'wildmenu' completion
		WinBar(surf_green_fg), -- Window bar of current window
		-- WinBarNC       (), -- Window bar of not-current windows

		-- See :h group-name
		--

		-- Comment        (), -- Any comment
		-- Barbar
		BufferCurrent(purple_fg),
		--BufferCurrentERROR(),
		--BufferCurrentHINT(),
		Constant(grey_fg), -- (*) Any constant
		String(surf_green_fg), --   A string constant: "this is a string"
		-- Character      (), --   A character constant: 'c', '\n'
		Number(purple_fg), --   A number constant: 234, 0xff
		Boolean(yellow_fg), --   A boolean constant: TRUE, false
		-- Float          (), --   A floating point constant: 2.3e10

		Identifier(grey_fg), -- (*) Any variable name
		Function(blue2_fg), --   Function name (also: methods for classes)

		Statement(purple_fg), -- (*) Any statement
		Conditional(purple_fg), --   if, then, else, endif, switch, etc.
		Repeat(purple_fg), --   for, do, while, etc.
		Label(purple_fg), --   case, default, etc.
		Operator(surf_green_fg), --   "sizeof", "+", "*", etc.
		Keyword(blue1_fg), --   any other keyword
		Exception(purple_fg), --   try, catch, throw

		-- PreProc        (), -- (*) Generic Preprocessor
		Include(purple_fg), --   Preprocessor #include
		-- Define         (), --   Preprocessor #define
		-- Macro          (), --   Same as Define
		-- PreCondit      (), --   Preprocessor #if, #else, #endif, etc.

		Type(blue1_fg), -- (*) int, long, char, etc.
		-- StorageClass   (), --   static, register, volatile, etc.
		Structure(purple_fg), --   struct, union, enum, etc.
		-- Typedef        (), --   A typedef

		-- Special        (), -- (*) Any special symbol
		-- SpecialChar    (), --   Special character in a constant
		Tag(yellow_fg), --   You can use CTRL-] on this
		Delimiter(yellow_fg), --   Character that needs attention
		-- SpecialComment (), --   Special things inside a comment (e.g. '\n')
		Debug(purple_fg), --   Debugging statements

		-- Underlined     { gui = "underline" }, -- Text that stands out, HTML links
		-- Ignore         (), -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
		Error(error_red_fg), -- Any erroneous construct
		-- Todo           (), -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

		-- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
		--
		LspReferenceText(blue1_fg), -- Used for highlighting "text" references
		-- LspReferenceRead            { } , -- Used for highlighting "read" references
		-- LspReferenceWrite           { } , -- Used for highlighting "write" references
		LspCodeLens(blue1_fg),                                        -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
		LspCodeLensSeparator(purple_fg),                              -- Used to color the seperator between two or more code lens.
		LspSignatureActiveParameter({ bg = purple.lighten(-10), fg = light_grey }), -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

		-- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
		--
		DiagnosticError(error_config), -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticWarn(warning_config), -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticInfo(blue2_fg),   -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticHint(blue1_fg),   -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticOk(surf_green_fg), -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticVirtualTextError(error_config), -- Used for "Error" diagnostic virtual text.
		-- DiagnosticVirtualTextWarn  () , -- Used for "Warn" diagnostic virtual text.
		-- DiagnosticVirtualTextInfo  () , -- Used for "Info" diagnostic virtual text.
		-- DiagnosticVirtualTextHint  () , -- Used for "Hint" diagnostic virtual text.
		-- DiagnosticVirtualTextOk    () , -- Used for "Ok" diagnostic virtual text.
		DiagnosticUnderlineError(error_red_fg), -- Used to underline "Error" diagnostics.
		-- DiagnosticUnderlineWarn    () , -- Used to underline "Warn" diagnostics.
		-- DiagnosticUnderlineInfo    () , -- Used to underline "Info" diagnostics.
		-- DiagnosticUnderlineHint    () , -- Used to underline "Hint" diagnostics.
		-- DiagnosticUnderlineOk      () , -- Used to underline "Ok" diagnostics.
		-- DiagnosticFloatingError    () , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
		-- DiagnosticFloatingWarn     () , -- Used to color "Warn" diagnostic messages in diagnostics float.
		-- DiagnosticFloatingInfo     () , -- Used to color "Info" diagnostic messages in diagnostics float.
		-- DiagnosticFloatingHint     () , -- Used to color "Hint" diagnostic messages in diagnostics float.
		-- DiagnosticFloatingOk       () , -- Used to color "Ok" diagnostic messages in diagnostics float.
		-- DiagnosticSignError        () , -- Used for "Error" signs in sign column.
		-- DiagnosticSignWarn         () , -- Used for "Warn" signs in sign column.
		-- DiagnosticSignInfo         () , -- Used for "Info" signs in sign column.
		-- DiagnosticSignHint         () , -- Used for "Hint" signs in sign column.
		-- DiagnosticSignOk           () , -- Used for "Ok" signs in sign column.

		--
		-- See :h treesitter-highlight-groups, some groups may not be listed,
		-- For more information see https://github.com/rktjmp/lush.nvim/issues/109
		-- sym("@lsp.type.property")(grey_fg),
		sym("@keyword")(purple_fg),
		sym("@keyword.coroutine")(blue2_fg),
		sym("@keyword.function")(purple_fg),
		sym("@keyword.operator")(purple_fg),
		sym("@keyword.import")(purple_fg),
		sym("@keyword.type")(purple_fg),
		sym("@keyword.modifier")(purple_fg),
		sym("@keyword.repeat")(purple_fg), --
		sym("@keyword.return")(purple_fg), --
		sym("@keyword.debug")(blue1_fg),
		sym("@keyword.exception")(purple_fg),
		sym("@keyword.conditional")(purple_fg),
		sym("@keyword.conditional.ternary")(yellow_fg),
		-- sym("@keyword.directive")(),
		-- sym("@keyword.directive.define")(),

		sym("@variable")(surf_green_fg),
		sym("@variable.builtin")(surf_green_fg),
		sym("@variable.parameter")(yellow_fg),
		sym("@variable.parameter.builtin")(yellow_fg),
		sym("@variable.member")(blue2_fg),

		sym("@variable.usage")(yellow_fg), -- Identifier
		sym("@constant")(grey_fg), -- Constant
		sym("@constant.builtin")(surf_green_fg), -- Special
		sym("@function")(blue2_fg), -- Function
		sym("@function.builtin")(blue2_fg), -- Special
		sym("@function.call")(blue2_fg),
		-- sym"@function.macro"    (), -- Macro

		sym("@boolean")(yellow_fg), -- Boolean
		sym("@number")(purple_fg),
		sym("@number.float")(purple_fg), -- Float
		sym("@parameter")(grey_fg), -- Identifier
		sym("@method")(blue2_fg), -- Function
		sym("@field")(yellow_fg), -- Identifier
		sym("@property")(yellow_fg), -- Identifier
		sym("@constructor")(purple_fg), -- Special
		sym("@conditional")(purple_fg), -- Conditional
		sym("@repeat")(purple_fg), -- Repeat

		sym("@operator")(surf_green_fg), -- Operator
		-- sym"@exception"         (), -- Exception
		sym("@type")(blue2_fg), -- Type
		sym("@type.definition")(grey_fg), -- Typedef
		sym("@type.builtin")(grey_white_fg),
		sym("@storageclass")(purple_fg), -- StorageClass
		sym("@structure")(purple_fg), -- Structure
		-- sym"@namespace"         (), -- Identifier
		-- sym"@include"           (), -- Include
		-- sym"@debug"             (), -- Debug
		sym("@string")(surf_green_fg),
		sym("@text.literal")(surf_green_fg), -- Comment
		-- sym"@text.reference"    (), -- Identifie    -- sym"@constant.macro"    { }, -- Define
		-- sym"@text.title"        (), -- Title        -- sym"@define"            { }, -- Define
		sym("@text.uri")(yellow_fg), -- Underlined     -- sym"@macro"             { }, -- Macro
		-- sym"@text.underline"    (), -- Underlined       --             { }, -- String
		-- sym"@text.todo"         (), -- Todo         -- sym"@string.escape"     { }, -- SpecialChar
		-- sym"@comment"           (), -- Comment        -- sym"@string.special"    { }, -- SpecialChar
		sym("@punctuation")(yellow_fg), -- Delimiter      -- sym"@character"         { }, -- Character
		-- sym"@label"             (), -- Label
		-- sym"@preproc"           (), -- PreProc
		sym("@tag")(yellow_fg), -- Tag
		sym("@tag.builtin")(yellow_fg),
	}
end)

-- Return our parsed theme for extension or use elsewhere.
return theme -- vi:nowrap
