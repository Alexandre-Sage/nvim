local Plug = { "nvim-treesitter/nvim-treesitter" }

Plug.dependencies = {
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  -- { 'TornaxO7/tree-setter' },
  --	{ "HiPhish/nvim-ts-rainbow2" },
  -- { "windwp/nvim-ts-autotag" },
}
Plug.build = ":TSUpdate"
Plug.lazy = false
-- See :help nvim-treesitter-modules
Plug.opts = {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },

  -- rainbow = { enable = true },
  autotag = { enabled = true },
  ensure_installed = {
    "javascript",
    "typescript",
    "tsx",
    "rust",
    "lua",
    "vim",
    "vimdoc",
    "css",
    "json",
    "yaml",
    "toml",
    "markdown",
    "git_config",
    "gitcommit",
    "git_rebase",
    "gitignore",
    "gitattributes",
    "json",
    "json5",
    "jsonc",
    "sql",
    "bash",
    "scss",
  },
}

function Plug.config(name, opts)
  require("nvim-treesitter.configs").setup(opts)
end

return Plug
