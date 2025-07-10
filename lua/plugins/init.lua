local Plugs = {
  {
    "vernette/ai-commit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("ai-commit").setup({
        -- your configuration
        {
          openrouter_api_key = "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", -- or set OPENROUTER_API_KEY environment variable
          model = "google/gemini-2.0-flash-001", -- default model
          auto_push = false, -- whether to automatically push after commit
        },
      })
    end,
  },
  { "MunifTanjim/nui.nvim" },
  -- {
  --   dir = "/home/adsoftware/.local/share/nvim/lazy/jwt-nvim",
  --   build = function()
  --     vim.fn.system("cargo build --release")
  --   end,
  --   config = function()
  --     require("jwt-nvim")
  --   end,
  -- },
  { "nvim-lua/plenary.nvim" },
  {
    "karb94/neoscroll.nvim",
    opts = {},
  },
  "Alexandre-Sage/blue-dream.nvim",
  -- { lazy = true, "rktjmp/shipwright.nvim" },
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
  -- { "folke/tokyonight.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  -- { "zootedb0t/citruszest.nvim" },
  -- { "mr-ubik/vim-hackerman-syntax" },
  { "xiyaowong/transparent.nvim" },
  -- { "maxmx03/fluoromachine.nvim" },
  -- { "samharju/synthweave.nvim" },
  -- { "lettertwo/laserwave.nvim" },
  { lazy = true, "Lewiky/moonokai" },
  -- { lazy = true, "cryptomilk/nightcity.nvim" },
  { "titanzero/zephyrium" },
  { lazy = true, "ofirgall/ofirkai.nvim" },
  -- { "tiagovla/tokyodark.nvim" },
  -- { "kevinm6/kurayami.nvim" },
  -----
  { "kdheepak/monochrome.nvim" },
  { "eldritch-theme/eldritch.nvim" },
  { "shaunsingh/moonlight.nvim" },
  { "darkvoid-theme/darkvoid.nvim" },
  -- { "dark-orchid/neovim" },
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      disable_mouse = false,
      disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "oil", "aerial", "dbui", "dbout" },
    },
  },
}

return Plugs
