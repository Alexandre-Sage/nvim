return {
  name = "yamlls",
  opts = {
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
          ["https://www.schemastore.org/github-workflow.json"] = "**ci.yml",
        },
      },
    },
  },
}
