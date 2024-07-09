local Plug = { "folke/which-key.nvim" }
Plug.enabled = true
Plug.event = "VeryLazy"
function Plug.init()
  vim.o.timeout = true
  vim.o.timeoutlen = 300
end
Plug.opts = {}
return Plug
