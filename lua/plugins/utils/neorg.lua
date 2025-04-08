local Plug = { "nvim-neorg/neorg" }

Plug.lazy = false -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
Plug.version = "*" -- Pin Neorg to the latest stable release
Plug.config = true

-- Plug.load = {
--   ["core.dirman"] = {
--     config = {
--       workspaces = {
--         neorg = "~/neorg",
--       },
--     },
--   },
-- }
require("neorg").setup({
  load = {
    ["core.defaults"] = {},
    ["core.completion"] = {},
    ["core.concealer"] = {
      folds = false,
      icon_preset = "diamond",
    },
    ["core.dirman"] = {
      config = {
        index = "index.norg",
        default_workspace = "neorg",
        workspaces = {
          neorg = "~/neorg",
          shared = "~/shared/neorg",
          -- default = { "~/neorg" },
        },
      },
    },
  },
})

return Plug
