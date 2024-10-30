local Plug = { "toppair/peek.nvim", lazy = true }

Plug.event = "VeryLazy"
Plug.build = "deno task --quiet build:fast"
Plug.config = function()
  require("peek").setup()
  vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
  vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
end

return Plug
