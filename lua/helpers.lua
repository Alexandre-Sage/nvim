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
return {
  create_user_command = create_user_command,
  map_key = vim.keymap.set,
  normal_cmd = normal_cmd,
  log_to_file = log_to_file,
}
