function create_user_command(name, call_back, args)
  return vim.api.nvim_create_user_command(name, call_back, { nargs = args })
end

local function normal_cmd(cmd)
  return "<cmd> :" .. cmd .. "<cr>"
end
local function log_to_file(path, message)
  local log_file = io.open(path, "a")
  if log_file ~= nil then
    log_file:write(tostring(message) .. "\n")
    log_file:close()
  end
end

local function concat_tables(...)
  local result = {}
  local current_index = 1

  for _, tbl in ipairs({ ... }) do
    table.move(tbl, 1, #tbl, current_index, result)
    current_index = current_index + #tbl
    -- table.insert(result, tbl)
  end

  return result
end

local function parse_key_map(keymaps)
  for _, keymap in pairs(keymaps) do
    vim.keymap.set(keymap[1], keymap[2], keymap[3], keymap[4])
  end
end

local function set_current_cursor_to_loclsit()
  local filename = vim.api.nvim_buf_get_name(0)
  local line_num = vim.api.nvim_win_get_cursor(0)[1]
  vim.fn.setloclist(0, {
    {
      filename = filename,
      lnum = line_num,
      col = vim.api.nvim_win_get_cursor(0)[2] + 1,
      text = "Saved location " .. filename .. " " .. line_num,
    },
  }, "a")
end

return {
  create_user_command = create_user_command,
  map_key = vim.keymap.set,
  normal_cmd = normal_cmd,
  log_to_file = log_to_file,
  concat_tables = concat_tables,
  parse_key_map = parse_key_map,
  set_current_cursor_to_loclsit = set_current_cursor_to_loclsit,
}
