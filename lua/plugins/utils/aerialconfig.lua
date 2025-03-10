local Plug = { "stevearc/aerial.nvim" }

Plug.dependencies = {
  "nvim-treesitter/nvim-treesitter",
  "nvim-tree/nvim-web-devicons",
}

Plug.opts = {
  backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
  layout = { min_width = 30 },
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
  ignore = {
    -- Ignore unlisted buffers. See :help buflisted
    unlisted_buffers = true,
    diff_windows = true,
    filetypes = { "unfocus", "switch_buffer", "unsupported", "curl" },
    buftypes = { "special", "curl" },
    wintypes = "special",
  },
  close_automatic_events = {},
  open_automatic = true,
  highlight_on_hover = true,
  autojump = true,
  lazy = true,
  lsp = {
    diagnostics_trigger_update = true,
    update_when_errors = true,
    update_delay = 300,
  },
}

function Plug.init()
  vim.keymap.set("n", "<leader>ta", "<cmd>AerialToggle!<CR>")
  vim.keymap.set("n", "<leader>a", "<cmd>AerialNavToggle<CR>")
  vim.keymap.set("n", "<leader>A", "<cmd>AerialOpen<CR>")
end

return Plug
