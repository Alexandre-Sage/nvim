return {
  name = "jsonls",
  opts = {
    filetypes = { "json", "jsonc" },
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
        --  Schemas https://www.schemastore.org
      },
    },
  },
}
-- return function(lspconfig, capabilities)
--   capabilities.textDocument.completion.completionItem.snippetSupport = true
--   lspconfig.jsonls.setup()
-- end
