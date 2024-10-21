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
  end

  return result
end

return {
  create_user_command = create_user_command,
  map_key = vim.keymap.set,
  normal_cmd = normal_cmd,
  log_to_file = log_to_file,
  concat_tables = concat_tables,
}
