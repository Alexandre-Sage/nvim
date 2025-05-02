---@module "ibl"
local Plug = { "lukas-reineke/indent-blankline.nvim" }
---@type ibl.config
Plug.opts = {
  exclude = {
    filetypes = {
      "Trouble",
      "alpha",
      "dashboard",
      "help",
      "lazy",
      "mason",
      "neo-tree",
      "notify",
      "snacks_dashboard",
      "snacks_notif",
      "snacks_terminal",
      "snacks_win",
      "toggleterm",
      "trouble",
    },
  },
}

Plug.main = "ibl"
return Plug
