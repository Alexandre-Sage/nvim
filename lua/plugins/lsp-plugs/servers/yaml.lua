return function(lspconfig, capabilities)
  require("lspconfig").yamlls.setup({
    settings = {
      yaml = {
        schemaStore = {
          -- You must disable built-in schemaStore support if you want to use
          -- this plugin and its advanced options like `ignore`.
          enable = true,
          -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        },
        schemas = {
          -- [require("schemastore").yaml.schemas({})] = true,
          ["https://www.artillery.io/schema.json"] = "**.artillery.yml",
        },
      },
    },
  })
end
-- extra = {
--   {
--     fileMatch = ".artillery.yml",
--     description = "Local JSON schema",
--     name = "artillery.json",
--     url = "https://www.artillery.io/schema.json", -- or '/path/to/your/schema.json'
--   },
-- },
