return function(lspconfig, lsp_cap, on_attach)
  lspconfig.lua_ls.setup({
    on_attach = on_attach,
    capabilites = lsp_cap,
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  })
end
