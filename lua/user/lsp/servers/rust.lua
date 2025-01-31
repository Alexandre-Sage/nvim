return {
  name = "rust_analyzer",
  opts = {
    settings = {
      ["rust-analyzer"] = {
        procMacro = {
          enable = true,
          attributes = {
            enable = true,
          },
        },
        cargo = {
          allFeatures = true,
        },
        assist = {
          emitMustUse = true,
        },
        checkOnSave = true,
        -- Enables all assist actions
        completion = {
          postfix = {
            enable = true,
          },
        },
        diagnostics = {
          enable = true,
          experimental = {
            enable = true,
          },
        },
      },
    },
  },
}
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
