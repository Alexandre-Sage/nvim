local Plug = { "stevearc/aerial.nvim" }
Plug.lazy_load = true
Plug.dependencies = {
  "nvim-treesitter/nvim-treesitter",
  "nvim-tree/nvim-web-devicons",
}

Plug.opts = {
  backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
  -- manage_folds = true,

  -- When you fold code with za, zo, or zc, update the aerial tree as well.
  -- Only works when manage_folds = true
  -- link_folds_to_tree = true,

  -- Fold code when you open/collapse symbols in the tree.
  -- Only works when manage_folds = true
  -- link_tree_to_folds = true,

  layout = { min_width = 30 },
  preserve_equality = true,
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
  ignore = {
    -- Ignore unlisted buffers. See :help buflisted
    unlisted_buffers = true,
    diff_windows = true,
    filetypes = { "unfocus", "switch_buffer", "unsupported", "curl", "jq", "bash", "zsh" },
    buftypes = { "special", "curl", "jq" },
    wintypes = "special",
  },
  show_guides = true,
  close_automatic_events = {
    "unsupported",
  },
  open_automatic = true,
  highlight_on_hover = true,
  autojump = true,
  lazy = true,
  lsp = {
    diagnostics_trigger_update = true,
    update_when_errors = true,
    update_delay = 300,
  },
  filter_kind = {
    "Array",
    "Boolean",
    "Class",
    "Constant",
    "Constructor",
    "Enum",
    "EnumMember",
    "Event",
    "Field",
    "File",
    "Function",
    "Interface",
    "Key",
    "Method",
    "Module",
    "Namespace",
    "Null",
    "Number",
    "Object",
    "Operator",
    "Package",
    "Property",
    "String",
    "Struct",
    "TypeParameter",
    "Variable",
  },
}

function Plug.init()
  vim.keymap.set("n", "<leader>ta", "<cmd>AerialToggle!<CR>")
  vim.keymap.set("n", "<leader>a", "<cmd>AerialNavToggle<CR>")
  vim.keymap.set("n", "<leader>A", "<cmd>AerialOpen<CR>")
end

return Plug
