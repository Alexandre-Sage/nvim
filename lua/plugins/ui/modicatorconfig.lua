local Plug = { "mawkler/modicator.nvim" }
Plug.dependencies = "Alexandre-Sage/blue-dream.nvim"
Plug.opts = {}
function Plug.init()
  vim.o.cursorline = true
  vim.o.number = true
  vim.o.termguicolors = true
end

return Plug
