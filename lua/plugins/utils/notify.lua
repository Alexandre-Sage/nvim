local Plug = { "rcarriga/nvim-notify" }

Plug.enabled = true

Plug.opts = {}

function Plug.init()
  vim.notify = require("notify")
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*",
    callback = function()
      local file_name = vim.fn.expand("%:t")
      vim.notify("Saving " .. file_name .. " ✓", vim.log.levels.INFO, {
        title = file_name,
        timeout = 2000,
        icon = "󰳿",
      })
    end,
  })
end

return Plug
