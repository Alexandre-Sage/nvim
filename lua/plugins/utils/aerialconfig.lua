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
    unlisted_buffers = false,
    diff_windows = true,
    filetypes = {},
    buftypes = "special",
    wintypes = "special",
  },
  open_automatic = true,
  lazy = true,
}

function Plug.init()
  vim.keymap.set("n", "<leader>ta", "<cmd>AerialToggle!<CR>")
  vim.keymap.set("n", "<leader>a", "<cmd>AerialNavToggle<CR>")
  vim.keymap.set("n", "<leader>A", "<cmd>AerialOpen<CR>")
end

return Plug
