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

vim.api.nvim_create_autocmd("Filetype", {
  pattern = "norg",
  callback = function()
    vim.keymap.set("n", "<CR>", "<Plug>(neorg.esupports.hop.hop-link)", { buffer = true })
  end,
})
Plug.opts = {
  load = {
    ["core.defaults"] = {},
    ["core.completion"] = { config = { engine = "nvim-cmp" } },
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
}

return Plug
