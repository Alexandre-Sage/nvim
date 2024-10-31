local Plug = { "stevearc/conform.nvim" }
Plug.event = { "BufWritePre" }
Plug.cmd = { "ConformInfo" }
Plug.opts = {
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { { "prettierd", "prettier" } },
    typescript = { { "prettierd", "prettier" } },
    typescriptreact = { { "prettierd", "prettier" } },
    javascriptreact = { { "prettierd", "prettier" } },
    yaml = { { "prettierd", "prettier" } },
    yml = { { "prettierd", "prettier" } },
    json = { { "prettierd", "prettier" } },
    json5 = { { "prettierd", "prettier" } },
    jsonc = { { "prettierd", "prettier" } },
    html = { { "prettierd", "prettier" } },
    sql = {
      -- { "sqlfmt" },
      { "sqlfluff" },
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
