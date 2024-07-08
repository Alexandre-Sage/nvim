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
    json = { { "prettierd", "prettier" } },
    json5 = { { "prettierd", "prettier" } },
    jsonc = { { "prettierd", "prettier" } },
    html = { { "prettierd", "prettier" } },
    sql = {
      -- { "sqlfmt" },
      { "sqlfluff" },
    },
  },
  -- Set up format-on-save
  format_on_save = { timeout_ms = 500, lsp_fallback = true },
  -- Customize formatters
  formatters = {
    prettier = {
      -- command = "my_cmd",
      args = {
        "--config-precedence",
        "prefer-file",
        --		"--trailing-comma", "all",
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
    -- Customize or remove this keymap to your liking
    "<leader>F",
    function()
      require("conform").format({ async = true, lsp_fallback = true })
    end,
    mode = "",
    desc = "Format buffer",
  },
}
return Plug
