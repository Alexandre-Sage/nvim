local Plug = { "rafamadriz/friendly-snippets" }
function Plug.config()
  require("luasnip.loaders.from_vscode").lazy_load({
    paths = { "~/.config/nvim/lua/plugins/lsp-plugs/snippets/snips/json" },
  })
end
return Plug
