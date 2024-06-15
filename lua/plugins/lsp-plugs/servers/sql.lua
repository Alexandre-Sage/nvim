return function(lspconfig)
  lspconfig.sqlls.setup({
    cmd = { "sql-language-server", "up", "--method", "stdio" },
    filtetypes = { "sql", "mysql" },
  })
end
