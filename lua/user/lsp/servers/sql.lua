return {
  name = "sqlls",
  opts = {
    -- root_dir = require("lspconfig").util.root_pattern("*.sql", ".git"),
    root_dir = "*.sql",
    cmd = { "sql-language-server", "up", "--method", "stdio" },
    filetypes = { "sql" },
  },
}
