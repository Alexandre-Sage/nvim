local Plug = {
  "kristijanhusak/vim-dadbod-ui",
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
  -- Your DBUI configuration
  vim.g.db_ui_use_nerd_fonts = 1
end
return Plug
