local Plugs = {
  {
    "stevearc/stickybuf.nvim",
    opts = {
      -- require("stickybuf").setup({
      -- This function is run on BufEnter to determine pinning should be activated
      get_auto_pin = function(bufnr)
        -- You can return "bufnr", "buftype", "filetype", or a custom function to set how the window will be pinned.
        -- You can instead return an table that will be passed in as "opts" to `stickybuf.pin`.
        -- The function below encompasses the default logic. Inspect the source to see what it does.
        return require("stickybuf").should_auto_pin(bufnr)
      end,
      -- }),

      buftype = {
        ["aerial"] = "aerial", -- Lock Aerial’s buffer to its window
        ["copen"] = "copen",
      },
    },
  },
  "Alexandre-Sage/blue-dream.nvim",
  { "ThePrimeagen/vim-be-good" },
  { "efueyo/td.nvim" },
  -- "lazyvim.config", --GIT
  -- "tpope/vim-fugitive",
  { lazy = true, "rktjmp/shipwright.nvim" },
  { lazy = true, "Xuyuanp/nerdtree-git-plugin" },
  -- UTILS
  { lazy = true, "mracos/mermaid.vim" },
  { "b0o/schemastore.nvim" },
  "sharkdp/fd",
  "BurntSushi/ripgrep",
  { lazy = true, "rktjmp/lush.nvim" },
  -- THEMES
  { "xero/miasma.nvim" },
  { lazy = true, "adamkali/vaporlush" },
  { "folke/tokyonight.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  { "zootedb0t/citruszest.nvim" },
  { "mr-ubik/vim-hackerman-syntax" },
  { "xiyaowong/transparent.nvim" },
  { "maxmx03/fluoromachine.nvim" },
  { "samharju/synthweave.nvim" },
  { "lettertwo/laserwave.nvim" },
  { lazy = true, "Lewiky/moonokai" },
  { lazy = true, "cryptomilk/nightcity.nvim" },
  { "titanzero/zephyrium" },
  { lazy = true, "ofirgall/ofirkai.nvim" },
  { "tiagovla/tokyodark.nvim" },
  { "kevinm6/kurayami.nvim" },
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      disable_mouse = false,
      disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "oil", "aerial", "dbui" },
    },
  },
  {
    "saecki/crates.nvim",
    tag = "stable",
    config = function()
      require("crates").setup({
        completion = {
          crates = {
            enabled = true, -- disabled by default
            max_results = 8, -- The maximum number of search results to display
            min_chars = 3, -- The minimum number of charaters to type before completions begin appearing
          },
          cmp = {
            enabled = true,
          },
        },
      })
      local crates = require("crates")
      local opts = { silent = true }
      vim.keymap.set("n", "<leader>cH", crates.open_homepage, {})
      vim.keymap.set("n", "<leader>cR", crates.open_repository, {})
      vim.keymap.set("n", "<leader>cD", crates.open_documentation, {})
      vim.keymap.set("n", "<leader>ct", crates.toggle, opts)
      vim.keymap.set("n", "<leader>cr", crates.reload, opts)

      vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, opts)
      vim.keymap.set("n", "<leader>cf", crates.show_features_popup, opts)
      vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, opts)
    end,
  },
}

return Plugs
