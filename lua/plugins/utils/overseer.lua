local Plug = { "stevearc/overseer.nvim" }

---@type overseer.Config
Plug.opts = {
  strategy = {
    -- "test",
    "toggleterm",
    -- direction = "horizontal",
    direction = "horizontal",
    open_on_start = false,
  },
  task_list = {
    default_detail = 2,
    height = 130,
    bindings = {
      ["<C-I>"] = "IncreaseDetail",
      ["<C-D>"] = "DecreaseDetail",
      ["o"] = "OpenSplit",
    },
  },
}

Plug.init = function()
  require("helpers").parse_key_map(require("user.keymaps.overseer"))
  local overseer = require("overseer")
  overseer.add_template_hook({ module = "^npm$" }, function(task_defn, util)
    util.add_component(task_defn, {
      "on_output_quickfix",
      open = false,
      items_only = true,
      open_on_match = false,
    })
  end)

  overseer.add_template_hook({ module = "^cargo$" }, function(task_defn, util)
    util.add_component(task_defn, {
      "on_output_quickfix",
      open = false,
      items_only = true,
      open_on_match = false,
    })
  end)
end
return Plug
