local function lsp_servers()
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return "No LSP"
  end
  local names = {}
  local seen = {} -- A table to track already seen clients

  for _, client in ipairs(clients) do
    if not seen[client.name] then
      table.insert(names, client.name) -- Add unique client name
      seen[client.name] = true -- Mark this name as seen
    end
  end
  return table.concat(names, " ")
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
    c = { fg = colors.white, bg = "#201f21" },
  },
  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = blue_1, guifg = colors.white },
    b = { fg = colors.white, bg = blue_1 },
    c = { fg = colors.white, bg = "#201f21" },
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
    "overseer",
  },
  options = {
    theme = bubbles_theme,
    component_separators = " 󱓇 ",
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = {
      {
        "mode",
        -- separator = { left = "" },
        padding = 3,
      },
    },
    lualine_b = { "filename", "branch" },
    lualine_c = {
      {
        "diagnostics",
        sources = { "nvim_diagnostic", "nvim_lsp" },
        sections = { "error", "warn", "info", "hint" },
        diagnostics_color = {
          error = "DiagnosticError",
          warn = "DiagnosticWarn",
          info = "DiagnosticInfo",
          hint = "DiagnosticHint",
        },
        symbols = { error = "❎", warn = "󰀧 ", info = "󰬐 ", hint = "󰞋 " },
        -- colored = true,
        update_in_insert = false,
        always_visible = false,
      },
    },
    lualine_x = {
      {
        function()
          local count = vim.fn.searchcount({ maxcount = 0 }).total
          return "󱁴 " .. count
        end,
        color = { fg = colors.cyan },
      },
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
      { "lsp_status", color = { fg = colors.violet } },
    },
    lualine_y = { "filetype", "progress" },
    lualine_z = {
      {
        "location",
        -- separator = { right = "" },
        left_padding = 2,
      },
    },
  },
  inactive_sections = {
    lualine_a = { "filename" },
    lualine_b = { "branch" },
    lualine_c = {},

    lualine_x = {
      {
        function()
          if vim.bo.modified then
            return "󰓧" -- Symbol indicating unsaved changes (customizable)
          else
            return "" -- Symbol indicating no unsaved changes
          end
        end,
        color = { fg = "#0afa82", guifg = colors.white }, -- Customize colors if needed
      },
      "lsp_status",
      -- { lsp_servers, color = { fg = colors.violet } },
    },
    lualine_y = { "filetype" },
    lualine_z = { "location" },
  },
}
return Plug
