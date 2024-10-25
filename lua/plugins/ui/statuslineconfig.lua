local colors = {
  blue = "#80a0ff",
  cyan = "#79dac8",
  black = "#080808",
  white = "#c6c6c6",
  red = "#ff5189",
  violet = "#d183e8",
  grey = "#303030",
}
local blue_1 = "#3477eb"
local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = blue_1 },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white, bg = colors.grey },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = blue_1 },
    b = { fg = colors.white, bg = blue_1 },
    c = { fg = colors.white, bg = colors.grey },
  },
}

local Plug = { "nvim-lualine/lualine.nvim" }

Plug.dependencies = { "nvim-tree/nvim-web-devicons" }
Plug.opts = {
  extensions = {
    "quickfix",
    "aerial",
    "oil",
    "toggleterm",
    "nvim-dap-ui",
  },
  options = {
    theme = bubbles_theme,
    component_separators = "󱓇",
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
    lualine_b = { "filename", "branch" },
    lualine_c = {
      "%=", --[[ add your center compoentnts here in place of this comment ]]
    },
    lualine_x = {},
    lualine_y = { "filetype", "progress" },
    lualine_z = {
      { "location", separator = { right = "" }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { "filename" },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { "location" },
  },
}
return Plug
