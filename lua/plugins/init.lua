local Plugs = {
  "stevearc/stickybuf.nvim",
  "Alexandre-Sage/blue-dream.nvim",
  { "ThePrimeagen/vim-be-good" },
  { "efueyo/td.nvim" },
  -- "lazyvim.config", --GIT
  -- "tpope/vim-fugitive",
  { lazy = true, "rktjmp/shipwright.nvim" },
  { lazy = true, "Xuyuanp/nerdtree-git-plugin" },
  -- UTILS
  { lazy = true, "mracos/mermaid.vim" },
  { lazy = true, "b0o/schemastore.nvim" },
  "sharkdp/fd",
  "BurntSushi/ripgrep",
  { lazy = true, "rktjmp/lush.nvim" },
  -- THEMES
  { lazy = true, "xero/miasma.nvim" },
  { lazy = true, "adamkali/vaporlush" },
  { lazy = true, "folke/tokyonight.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  { lazy = true, "zootedb0t/citruszest.nvim" },
  { "mr-ubik/vim-hackerman-syntax" },
  { "xiyaowong/transparent.nvim" },
  { lazy = true, "samharju/synthweave.nvim" },
  { lazy = true, "lettertwo/laserwave.nvim" },
  { lazy = true, "Lewiky/moonokai" },
  { lazy = true, "cryptomilk/nightcity.nvim" },
  { lazy = true, "titanzero/zephyrium" },
  { lazy = true, "ofirgall/ofirkai.nvim" },
  { lazy = true, "tiagovla/tokyodark.nvim" },
  { lazy = true, "kevinm6/kurayami.nvim" },
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      disable_mouse = false,
      disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "oil", "aerial" },
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
    end,
  },
}

return Plugs
