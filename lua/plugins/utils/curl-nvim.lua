local Plug = {
  "oysandvik94/curl.nvim",
}
Plug.cmd = { "CurlOpen" }
Plug.dependencies = {
  "nvim-lua/plenary.nvim",
}
Plug.opts = {
  open_with = "tab",
  default_flags = {
    ["-H"] = "content-type: application/json",
  },
}
-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
--   pattern = "Curl output_*",
--   callback = function()
--     vim.api.nvim_command("vsplit")
--     vim.bo.filetype = "json"
--     vim.wo.wrap = true
--   end,
-- })
function Plug.init()
  local curl = require("curl")
  vim.keymap.set("n", "<leader>cc", function()
    curl.open_curl_tab()
  end, { desc = "Open a curl tab scoped to the current working directory" })

  vim.keymap.set("n", "<leader>co", function()
    curl.open_global_tab()
  end, { desc = "Open a curl tab with gloabl scope" })

  -- These commands will prompt you for a name for your collection
  vim.keymap.set("n", "<leader>csc", function()
    curl.create_scoped_collection()
  end, { desc = "Create or open a collection with a name from user input" })

  vim.keymap.set("n", "<leader>cgc", function()
    curl.create_global_collection()
  end, { desc = "Create or open a global collection with a name from user input" })

  vim.keymap.set("n", "<leader>fsc", function()
    curl.pick_scoped_collection()
  end, { desc = "Choose a scoped collection and open it" })

  vim.keymap.set("n", "<leader>fgc", function()
    curl.pick_global_collection()
  end, { desc = "Choose a global collection and open it" })
end

return Plug
