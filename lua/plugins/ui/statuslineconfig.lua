local function lsp_servers()
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return "No LSP"
  end
  local names = {}
  for _, client in ipairs(clients) do
    table.insert(names, client.name)
  end
  return table.concat(names, ", ")
end
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
    c = { fg = colors.white },
  },
  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = blue_1 },
    b = { fg = colors.white, bg = blue_1 },
    c = { fg = colors.white },
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
    component_separators = " 󱓇 ",
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
    lualine_b = { "filename", "branch" },
    lualine_c = {
      {
        "diagnostics",

        -- Table of diagnostic sources, available sources are:
        --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
        -- or a function that returns a table as such:
        --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
        sources = { "nvim_diagnostic", "coc", "nvim_lsp" },

        -- Displays diagnostics for the defined severity types
        sections = { "error", "warn", "info", "hint" },

        diagnostics_color = {
          -- Same values as the general color option can be used here.
          error = "DiagnosticError", -- Changes diagnostics' error color.
          warn = "DiagnosticWarn", -- Changes diagnostics' warn color.
          info = "DiagnosticInfo", -- Changes diagnostics' info color.
          hint = "DiagnosticHint", -- Changes diagnostics' hint color.
        },
        symbols = { error = "❎", warn = "󰀧 ", info = "󰬐 ", hint = "󰞋 " },
        colored = true, -- Displays diagnostics status in color if set to true.
        update_in_insert = false, -- Update diagnostics in insert mode.
        always_visible = false, -- Show diagnostics even if there are none.
      },
    },
    lualine_x = {
      {
        function()
          if vim.bo.modified then
            return "󰓧" -- Symbol indicating unsaved changes (customizable)
          else
            return "" -- Symbol indicating no unsaved changes
          end
        end,
        color = { fg = "#0afa82" }, -- Customize colors if needed
      },
      {
        function()
          return vim.fn.getcwd() -- Get current working directory
        end,
      },
      { lsp_servers, color = { fg = colors.violet } },
    },
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
