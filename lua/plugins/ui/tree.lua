local Plug = { "nvim-tree/nvim-tree.lua" }

local function my_on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set("n", "<c-t>", api.node.open.tab, opts("Open in tab"))
  vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
  vim.keymap.set("n", "<c-b>", api.tree.toggle)
  vim.keymap.set("n", "<leader>n", api.tree.open)
  vim.keymap.set("n", "nd", api.node.navigate.diagnostics.next)
  vim.keymap.set("n", "pd", api.node.navigate.diagnostics.prev)
end

Plug.lazy = false

Plug.dependencies = {
  "nvim-tree/nvim-web-devicons",
}

Plug.opts = {
  on_attach = my_on_attach,
  update_focused_file = { enable = true },
  sync_root_with_cwd = true,
  -- prefer_startup_root = true,
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = true,
  },
  filters = {
    enable = true,
    git_ignored = false,
    dotfiles = false,
    custom = { "node_modules" },
  },
  git = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = true,
    ignore = false,
  },
}

return Plug
