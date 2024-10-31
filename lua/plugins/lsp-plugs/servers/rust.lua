local s = {
  name = "rust_analyzer",
  opts = require("rust-tools").setup({
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
        },
      },
    },
  }),
}
return s
-- return function(lspconfig, capabilities)
--   require("rust-tools").setup({
--     settings = {
--       ["rust-analyzer"] = {
--         cargo = {
--           allFeatures = true,
--         },
--       },
--     },
--     capabilities = capabilities,
--   })
-- end
