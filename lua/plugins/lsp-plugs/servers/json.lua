-- local capabilities = vim.lsp.protocol.make_client_capabilities()
return function(lspconfig, capabilities, on_attach)
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  lspconfig.jsonls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "json", "jsonc" },
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
        --  Schemas https://www.schemastore.org
      },
    },
  })
end
