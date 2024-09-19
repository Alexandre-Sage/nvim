local Plug = {
  "oysandvik94/curl.nvim",
}
Plug.cmd = { "CurlOpen" }
Plug.dependencies = {
  "nvim-lua/plenary.nvim",
}
-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
--   pattern = "Curl output_*",
--   callback = function()
--     vim.api.nvim_command("vsplit")
--     vim.bo.filetype = "json"
--     vim.wo.wrap = true
--   end,
-- })
function Plug.init() end
Plug.config = true
return Plug
