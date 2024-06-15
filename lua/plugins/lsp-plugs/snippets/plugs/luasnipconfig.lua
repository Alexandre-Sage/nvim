local Plug = { "L3MON4D3/LuaSnip" }

Plug.depencies = {
  "saadparwaiz1/cmp_luasnip",
  "rafamadriz/friendly-snippets",
  "luasnip_snippets.nvim",
}
Plug.want = {}
Plug.build = "make install_jsregexp"

function Plug.config() end

return Plug
