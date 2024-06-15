local lush = require("lush")
local hsl = lush.hsl

-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
  local sym = injected_functions.sym
  return {
    -- Neovim highlight groups
    Normal({ bg = hsl("#0f0f0f"), fg = hsl("#eeffff") }),
    Menu({ bg = hsl("#0f0f0f") }),
    MenuSel({ bg = hsl("#101010cc"), fg = hsl("#eeffff") }),
    SideBar({ bg = hsl("#101010cc") }),
    SideBarTitle({ fg = hsl("#02bbfb") }),
    TabLine({ bg = hsl("#101010cc"), fg = hsl("#00f6ff33") }),
    TabLineSel({ bg = hsl("#101010cc") }),
    TabLineFill({ bg = hsl("#101010cc") }),
    CursorLine({ bg = hsl("#101010cc") }),
    CursorLineNr({ fg = hsl("#02bbfb") }),
    VertSplit({ fg = hsl("#101010cc") }),
    StatusLine({ bg = hsl("#101010cc") }),
    StatusLineNC({ bg = hsl("#101010cc") }),
    Title({ fg = hsl("#02bbfb") }),
    LineNr({ fg = hsl("#02bbfb") }),
    Comment({ fg = hsl("#f70202"), gui = "italic" }),
    Pmenu({ bg = hsl("#101010cc"), fg = hsl("#eeffff") }),
    PmenuSel({ bg = hsl("#101010cc"), fg = hsl("#eeffff") }),
    PmenuSbar({ bg = hsl("#101010cc") }),
    PmenuThumb({ bg = hsl("#02bbfb") }),
    MatchParen({ fg = hsl("#FF5370"), gui = "bold" }),
    ErrorMsg({ fg = hsl("#FF5370") }),
    IncSearch({ bg = hsl("#101010cc"), fg = hsl("#eeffff"), gui = "bold" }),
    Search({ bg = hsl("#101010cc"), fg = hsl("#eeffff"), gui = "bold" }),
    Visual({ bg = hsl("#101010cc"), gui = "bold" }),
    WarningMsg({ fg = hsl("#FFCB6B"), gui = "bold" }),
    -- Additional groups can be defined here...

    -- Syntax groups
    Function({ fg = hsl("#00f6ff") }),
    Identifier({ fg = hsl("#ff007b") }),
    Type({ fg = hsl("#02fbbd") }),
    Keyword({ fg = hsl("#C792EA") }),
    Constant({ fg = hsl("#00f6ff") }),
    String({ fg = hsl("#ff007b") }),
    Number({ fg = hsl("#F78C6C") }),
    Boolean({ fg = hsl("#00f6ff") }),
    Operator({ fg = hsl("#89DDFF") }),
    Error({ fg = hsl("#FF5370") }),
    Todo({ fg = hsl("#EEFFFF"), bg = hsl("#65737E"), gui = "bold" }),
    MatchParen({ fg = hsl("#FF5370"), gui = "bold" }),

    -- LSP diagnostic groups
    DiagnosticError({ fg = hsl("#FF5370") }),
    DiagnosticWarn({ fg = hsl("#FFCB6B") }),
    DiagnosticInfo({ fg = hsl("#82AAFF") }),
    DiagnosticHint({ fg = hsl("#89DDFF") }),
    DiagnosticVirtualTextError({ fg = hsl("#FF5370") }),
    DiagnosticVirtualTextWarn({ fg = hsl("#FFCB6B") }),
    DiagnosticVirtualTextInfo({ fg = hsl("#82AAFF") }),
    DiagnosticVirtualTextHint({ fg = hsl("#89DDFF") }),
    DiagnosticUnderlineError({ gui = "underline", sp = hsl("#FF5370") }),
    DiagnosticUnderlineWarn({ gui = "underline", sp = hsl("#FFCB6B") }),
    DiagnosticUnderlineInfo({ gui = "underline", sp = hsl("#82AAFF") }),
    DiagnosticUnderlineHint({ gui = "underline", sp = hsl("#89DDFF") }),
    DiagnosticFloatingError({ fg = hsl("#FF5370") }),
    DiagnosticFloatingWarn({ fg = hsl("#FFCB6B") }),
    DiagnosticFloatingInfo({ fg = hsl("#82AAFF") }),
    DiagnosticFloatingHint({ fg = hsl("#89DDFF") }),
    DiagnosticSignError({ fg = hsl("#FF5370") }),
    DiagnosticSignWarn({ fg = hsl("#FFCB6B") }),
    DiagnosticSignInfo({ fg = hsl("#82AAFF") }),
    DiagnosticSignHint({ fg = hsl("#89DDFF") }),

    -- Tree-sitter highlight groups
    sym("@function")({ fg = hsl("#00f6ff") }),
    sym("@keyword.function")({ fg = hsl("#C792EA") }),
    sym("@method")({ fg = hsl("#02bbfb") }),
    sym("@field")({ fg = hsl("#ff007b") }),
    sym("@variable")({ fg = hsl("#5a6e72") }),
    sym("@constant")({ fg = hsl("#00f6ff") }),
    sym("@string")({ fg = hsl("#ff007b") }),
    sym("@number")({ fg = hsl("#F78C6C") }),
    sym("@boolean")({ fg = hsl("#00f6ff") }),
    sym("@parameter")({ fg = hsl("#5a6e72") }),
    sym("@property")({ fg = hsl("#ff007b") }),
    sym("@type")({ fg = hsl("#02fbbd") }),
    sym("@punctuation.delimiter")({ fg = hsl("#89DDFF") }),
    sym("@punctuation.bracket")({ fg = hsl("#89DDFF") }),
    sym("@punctuation.special")({ fg = hsl("#89DDFF") }),
    sym("@comment")({ fg = hsl("#546E7A"), gui = "italic" }),
    sym("@operator")({ fg = hsl("#89DDFF") }),
    sym("@tag")({ fg = hsl("#f07178") }),
    sym("@tag.delimiter")({ fg = hsl("#89DDFF") }),
    sym("@text")({ fg = hsl("#EEFFFF") }),
    sym("@emphasis")({ fg = hsl("#f07178"), gui = "italic" }),
    sym("@underline")({ fg = hsl("#F78C6C"), gui = "underline" }),
    sym("@title")({ fg = hsl("#C3E88D"), gui = "bold" }),
    sym("@uri")({ fg = hsl("#82AAFF"), gui = "underline" }),
    sym("@variable.builtin")({ fg = hsl("#FF5370") }),
    sym("@type.builtin")({ fg = hsl("#FFCB6B") }),
    sym("@attribute")({ fg = hsl("#C792EA") }),
    sym("@namespace")({ fg = hsl("#FFCB6B") }),
    sym("@string.escape")({ fg = hsl("#89DDFF") }),
    sym("@regexp")({ fg = hsl("#89DDFF") }),

    -- Markdown specific highlights
    markdownHeadingDelimiter({ fg = hsl("#C3E88D") }),
    markdownCode({ fg = hsl("#C792EA") }),
    markdownCodeBlock({ fg = hsl("#C792EA") }),
    markdownLinkText({ fg = hsl("#82AAFF"), gui = "underline" }),
    markdownLinkTextDelimiter({ fg = hsl("#65737E") }),
  }
end)

-- Return our parsed theme for extension or use elsewhere.
return theme
