local Plug = { "altermo/ultimate-autopair.nvim", branch = "v0.6" }

Plug.event = { "InsertEnter", "CmdlineEnter" }
Plug.opts = {
  fastwarp = {
    multi = true,
    {},
    {
      faster = true,
      -- map='<C-A-e>',
      -- cmap='<C-A-e>'
    },
  },
}

return Plug
