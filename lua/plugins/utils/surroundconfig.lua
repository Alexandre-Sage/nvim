local Plug = { "ur4ltz/surround.nvim" }

function Plug.config()
  require("surround").setup({
    mappings_style = "sandwich",
  })
end

return Plug
