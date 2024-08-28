local Plug = { "gennaro-tedesco/nvim-jqx" }

function Plug.init()
  local jqx_group = vim.api.nvim_create_augroup("Jqx", {})
  local jqx = require("nvim-jqx.config")
  jqx.geometry.border = "single"
  jqx.geometry.width = 0.8
  jqx.geometry.height = 0.7
  jqx.query_key = "jqx" -- keypress to query jq on keys
  jqx.sort = false -- show the json keys as they appear instead of sorting them alphabetically
  jqx.show_legend = true -- show key queried as first line in the jqx floating window
  jqx.use_quickfix = false -- if you prefer the location list
  vim.api.nvim_clear_autocmds({ group = jqx_group })
  vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = { "*.json", "*.yaml" },
    desc = "preview json and yaml files on open",
    group = jqx_group,
    callback = function()
      vim.cmd.JqxList()
    end,
  })
end

return Plug
