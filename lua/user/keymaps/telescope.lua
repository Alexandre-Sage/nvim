return {
  {
    { "n" },
    "<leader>ff",
    function()
      require("telescope.builtin").find_files({
        no_ignore = true,
        hidden = true,
        file_ignore_patterns = { "*/.git/*", "node_modules", "dist", "build", "target" },
      })
    end,
    { noremap = true, desc = "Find file in root workspace" },
  },
  {
    { "n" },
    "<leader>lg",
    function()
      return require("telescope.builtin").live_grep({
        no_ignore = true,
        hidden = true,
        file_ignore_patterns = { "node_modules", "pnpm-lock.yaml", "package-lock.json", "yarn.lock" },
      })
    end,
    { noremap = true },
  },
  {
    { "n" },
    "<leader>lG",
    function()
      return require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })
    end,
    { noremap = true },
  },
  {
    { "n" },
    "<leader>fb",
    function()
      return require("telescope.builtin").current_buffer_fuzzy_find({ results_ts_highlight = true })
    end,
    { noremap = true },
  },
  {
    { "n" },
    "<leader>b",
    function()
      return require("telescope.builtin").buffers({
        sort_mru = true,
        only_cwd = true,
      })
    end,
    { noremap = true },
  },
  {
    { "n" },
    "<leader>B",
    function()
      return require("telescope.builtin").buffers({
        sort_mru = true,
      })
    end,
    { noremap = true },
  },
  {
    { "n" },
    "<leader>dg",
    function()
      return require("telescope.builtin").diagnostics({ bufnr = 0 })
    end,
    { noremap = true, desc = "Show LSP diag for current buffer" },
  },
  { { "n", "v" }, "<leader>fr", require("telescope.builtin").lsp_references, { noremap = true } },
  { { "n", "v" }, "<leader>fd", require("telescope.builtin").lsp_definitions, { noremap = true } },
  { { "n" }, "<leader>ic", require("telescope.builtin").lsp_incoming_calls, { noremap = true } },
  { { "n" }, "<leader>fm", require("telescope.builtin").marks, { noremap = true } },
  { { "n" }, "<leader>Rr", require("telescope.builtin").registers, { noremap = true } },
  {
    { "n" },
    "<leader>pd",
    function()
      return require("telescope.builtin").diagnostics({ severity = vim.diagnostic.severity.ERROR })
    end,
    { noremap = true },
  },
  { { "n" }, "<leader>pD", require("telescope.builtin").diagnostics, { noremap = true } },
  { { "n" }, "<leader>tt", require("telescope-tabs").list_tabs, { noremap = true } },
}
