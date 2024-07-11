local Plug = { "rcarriga/nvim-notify" }

Plug.enabled = true

Plug.opts = {}

function Plug.init()
  vim.notify = require("notify")
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*",
    callback = function()
      local file_name = vim.fn.expand("%:t")
      vim.notify("File saved: " .. file_name, 3, {
        title = "Notification",
        timeout = 2000,
      })
    end,
  })
end

return Plug
