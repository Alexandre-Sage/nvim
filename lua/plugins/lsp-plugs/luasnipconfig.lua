local Plug = { "L3MON4D3/LuaSnip" }

Plug.depencies = {
  "saadparwaiz1/cmp_luasnip",
  "rafamadriz/friendly-snippets",
  "luasnip_snippets.nvim",
  {
    "rafamadriz/friendly-snippets",
    enabled = false,
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({
        --     paths = { "~/.config/nvim/lua/plugins/lsp-plugs/snippets/snips/json" },
      })
    end,
    build = "make install_jsregexp",
  },
}

function Plug.config() end

return Plug
