return {
  lspconfig = {
    { { "n", "v" }, "D", vim.diagnostic.open_float, { desc = "Current diagnostic" } },
    { { "n", "v" }, "<leader>dp", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" } },
    { { "n", "v" }, "<leader>dn", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" } },
    { { "n", "v" }, "<space>q", vim.diagnostic.setloclist, { desc = "Set loc list" } },
  },
  attach = function(buf)
    return {
      { { "n" }, "K", vim.lsp.buf.hover, { buffer = buf, desc = "todo" } },
      { { "n" }, "<C-k>", vim.lsp.buf.signature_help, { buffer = buf, desc = "todo" } },
      { { "n" }, "<leader>wa", vim.lsp.buf.add_workspace_folder, { buffer = buf, desc = "todo" } },
      { { "n" }, "<leader>wr", vim.lsp.buf.remove_workspace_folder, { buffer = buf, desc = "todo" } },
      { { "n" }, "<leader>wl", vim.lsp.buf.list_workspace_folders, { buffer = buf, desc = "todo" } },
      { { "n" }, "<space>D", vim.lsp.buf.type_definition, { buffer = buf, desc = "todo" } },
      { { "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = buf, desc = "todo" } },
    }
  end,
}
