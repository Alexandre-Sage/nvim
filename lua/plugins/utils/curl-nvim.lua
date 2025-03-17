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
--
Plug.tile_response_to_curl_tab = function()
  local curl_tab_id = nil
  local curl_buf_id = nil

  -- Function to ensure curl tab exists or create it
  local function ensure_curl_tab()
    if curl_tab_id and vim.api.nvim_tabpage_is_valid(curl_tab_id) then
      return curl_tab_id, curl_buf_id
    else
      -- Create a new tab for curl responses
      vim.cmd("tabnew")
      curl_tab_id = vim.api.nvim_get_current_tabpage()
      curl_buf_id = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_set_name(curl_buf_id, "curl-responses")
      return curl_tab_id, curl_buf_id
    end
  end

  -- Override the curl.nvim display function
  local original_display_fn = vim.g.curl_nvim_display_fn or function() end
  vim.g.curl_nvim_display_fn = function(response, request)
    -- Save current tab
    local current_tab = vim.api.nvim_get_current_tabpage()

    -- Ensure curl tab exists and switch to it
    local curl_tab, curl_buf = ensure_curl_tab()
    vim.api.nvim_set_current_tabpage(curl_tab)

    -- Call original display function or use default behavior
    if type(original_display_fn) == "function" then
      original_display_fn(response, request)
    else
      -- Default display behavior if no original function
      local lines = vim.split(response, "\n")
      vim.api.nvim_buf_set_lines(curl_buf, 0, -1, false, lines)
    end

    -- Optionally return to the original tab if desired
    -- Uncomment this if you want to go back to where you were
    -- vim.api.nvim_set_current_tabpage(current_tab)
  end
end
function Plug.init()
  Plug.tile_response_to_curl_tab()
  require("helpers").parse_key_map(require("user.keymaps.curl"))

  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "Curl output_*", -- Pattern matching all Curl output buffers
    callback = function()
      -- Clear error highlighting for this buffer only
      -- vim.api.nvim_buf_set_option(0, "syntax", "OFF") -- Optional: disable syntax completely

      vim.cmd("hi! link Error NONE")
      vim.cmd("hi! link @Error NONE")
      vim.cmd("hi! link DiagnosticError NONE")
    end,
  })
end

return Plug
