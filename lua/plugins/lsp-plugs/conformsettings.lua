local Plug = { "stevearc/conform.nvim" }
Plug.event = { "BufWritePre" }
Plug.cmd = { "ConformInfo" }
Plug.opts = {
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettierd", "prettier", stop_after_first = false },
    typescript = { "prettierd", "prettier", stop_after_first = false },
    typescriptreact = { "prettierd", "prettier", stop_after_first = false },
    javascriptreact = { "prettierd", "prettier", stop_after_first = false },
    yaml = { "prettierd", "prettier", stop_after_first = false },
    yml = { "prettierd", "prettier", stop_after_first = false },
    json = { "prettierd", "prettier", stop_after_first = false },
    json5 = { "prettierd", "prettier", stop_after_first = false },
    jsonc = { "prettierd", "prettier", stop_after_first = false },
    html = { "prettierd", "prettier", stop_after_first = false },
    sql = {
      -- { "sqlfmt" },
      "sqlfluff",
    },
  },
  format_on_save = { timeout_ms = 500, lsp_fallback = true },
  formatters = {
    prettier = {
      args = {
        "--config-precedence",
        "prefer-file",
        "--no-semi",
        false,
        "--single-quote",
        true,
        "--arrow-parens",
        "always",
        "--experimental-ternaries",
        true,
        "--tab-width",
        2,
        "--use-tabs",
        false,
        "--parser",
        "typescript",
      },
    },
    shfmt = {
      prepend_args = { "-i", "2" },
    },
  },
}
Plug.keys = {
  {
    "<leader>F",
    function()
      require("conform").format({ async = true, lsp_fallback = true })
    end,
    mode = "",
    desc = "Format buffer",
  },
}
return Plug
