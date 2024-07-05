local helpers = require("helpers")
local language_specific_hidden = { "node_modules", "target" }
local Plug = { "stevearc/oil.nvim" }
Plug.dependencies = { "nvim-tree/nvim-web-devicons" }

Plug.opts = {
  lsp_file_methods = {
    timeout_ms = 1000,
    autosave_changes = false,
  },
  view_options = {
    is_hidden_file = function(name, _)
      return language_specific_hidden[name] -- vim.startswith(name, ".")
    end,
    is_always_hidden = function(name, _)
      return name == ".git"
    end,
  },
}
function Plug.init()
  local oil = require("oil")
  helpers.map_key({ "n" }, "<leader>o", oil.toggle_float, { desc = "Toogle oil pop up" })
  helpers.map_key({ "n" }, "<leader>O", oil.open, { desc = "Open oil buffer" })
end

return Plug
