local Plug = {
  "saecki/crates.nvim",
  tag = "stable",
}

Plug.config = function()
  require("crates").setup({
    lsp = {
      enabled = true,
      on_attach = function(client, bufnr)
        -- the same on_attach function as for your other lsp's
      end,
      actions = true,
      completion = true,
      hover = true,
    },
    completion = {
      cmp = {
        enabled = true,
      },
    },
  })
end
-- {
--   "saecki/crates.nvim",
--   tag = "stable",
--   config = function()
--     require("crates").setup({
--       completion = {
--         crates = {
--           enabled = true, -- disabled by default
--           max_results = 8, -- The maximum number of search results to display
--           min_chars = 3, -- The minimum number of charaters to type before completions begin appearing
--         },
--         cmp = {
--           enabled = true,
--         },
--       },
--     })
--     local crates = require("crates")
--     local opts = { silent = true }
--     vim.keymap.set("n", "<leader>cH", crates.open_homepage, {})
--     vim.keymap.set("n", "<leader>cR", crates.open_repository, {})
--     vim.keymap.set("n", "<leader>cD", crates.open_documentation, {})
--     vim.keymap.set("n", "<leader>ct", crates.toggle, opts)
--     vim.keymap.set("n", "<leader>cr", crates.reload, opts)
--
--     vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, opts)
--     vim.keymap.set("n", "<leader>cf", crates.show_features_popup, opts)
--     vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, opts)
--   end,
-- },
return Plug
