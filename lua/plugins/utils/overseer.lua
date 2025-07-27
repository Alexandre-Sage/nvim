local Plug = { "stevearc/overseer.nvim" }

---@type overseer.Config
Plug.opts = {
  strategy = {
    -- "test",
    "toggleterm",
    -- direction = "horizontal",
    direction = "float",
    open_on_start = false,
  },
  task_list = {
    default_detail = 3,
    height = 130,
  },
}

return Plug
