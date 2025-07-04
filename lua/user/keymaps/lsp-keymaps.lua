return {
  lspconfig = {
    {
      { "n", "v" },
      "D",
      function()
        vim.diagnostic.open_float({ border = "rounded" })
      end,
      { desc = "Current diagnostic" },
    },
    { { "n", "v" }, "<leader>dp", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" } },
    { { "n", "v" }, "<leader>dn", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" } },
    -- { { "n", "v" }, "<space>q", vim.diagnostic.setloclist, { desc = "Set loc list" } },
    {
      { "n", "v" },
      "<space>qe",
      function()
        vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR, open = false })
      end,
      { desc = "Set loc list" },
    },
  },
  attach = function(buf)
    return {
      {
        { "n" },
        "K",
        function()
          vim.lsp.buf.hover({ border = "single" })
        end,
        { buffer = buf, desc = "todo" },
      },
      -- { { "n" }, "<C-k>", vim.lsp.buf.signature_help, { buffer = buf, desc = "todo" } },
      { { "n" }, "<leader>wa", vim.lsp.buf.add_workspace_folder, { buffer = buf, desc = "todo" } },
      { { "n" }, "<leader>wr", vim.lsp.buf.remove_workspace_folder, { buffer = buf, desc = "todo" } },
      { { "n" }, "<leader>wl", vim.lsp.buf.list_workspace_folders, { buffer = buf, desc = "todo" } },
      { { "n" }, "<space>D", vim.lsp.buf.type_definition, { buffer = buf, desc = "todo" } },
      { { "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = buf, desc = "todo" } },
      { { "n" }, "<leader>ws", vim.lsp.buf.workspace_symbol, { desc = "todo" } },
    }
  end,
}
