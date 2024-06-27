local Plug = { "romgrk/barbar.nvim" }
Plug.opt = {
  exclude_ft = { "buffer", "qf", "aerial", "<Aerial", "%buffer%", "[buffer ]" },
  exclude_name = { "package.json", "**buffer**", "<Aerial" },
}
return Plug
