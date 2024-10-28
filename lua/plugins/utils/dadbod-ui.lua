local helpers = require("helpers")
local Plug = {
  "kristijanhusak/vim-dadbod-ui",
}

local keymaps = {
  { { "n" }, "<leader>dbu", helpers.normal_cmd("DBUI"), { desc = "toggle dbui" } },
}
Plug.dependencies = {
  { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
  { "tpope/vim-dadbod", lazy = true },
}
Plug.cmd = {
  "DBUI",
  "DBUIToggle",
  "DBUIAddConnection",
  "DBUIFindBuffer",
}

Plug.lazy = true

Plug.opts = {}
Plug.init = function()
  vim.g.db_ui_use_nerd_fonts = 1
  helpers.parse_key_map(keymaps)
end
return Plug
