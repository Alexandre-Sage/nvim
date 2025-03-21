local Plug = { "rcarriga/nvim-notify" }

Plug.enabled = true

Plug.opts = {
  background_colour = "#1f1f1f",
}

function Plug.init()
  vim.notify = require("notify")
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*",
    callback = function()
      local file_name = vim.fn.expand("%:t")
      vim.notify("Saving " .. file_name .. " ✓", vim.log.levels.INFO, {
        title = file_name,
        timeout = 1000,
        icon = "󰳿",
        top_down = true,
      })
    end,
  })
end

return Plug
