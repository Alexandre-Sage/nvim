local Plug = { "aznhe21/actions-preview.nvim" }
Plug.enabled = false
Plug.opt = {
  telescope = {
    sorting_strategy = "ascending",
    layout_strategy = "vertical",
    layout_config = {
      width = 0.8,
      height = 0.9,
      prompt_position = "top",
      preview_cutoff = 20,
      preview_height = function(_, _, max_lines)
        return max_lines - 15
      end,
    },
  },
}

function Plug.init()
  require("helpers").map_key({ "v", "n" }, "<leader>ca", require("actions-preview").code_actions)
end
return Plug
