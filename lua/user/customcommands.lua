local create_command = vim.api.nvim_create_user_command
local crate_buff_command = vim.api.nvim_buf_create_user_command
crate_buff_command(0, "Upper", function(opts)
  print(string.upper(opts.fargs[1]))
end, { nargs = 1 })

create_command("Fx", function(opt)
  vim.cmd("/\\<" .. opt.fargs[1] .. "\\>")
end, { nargs = 1 })

create_command("Fr", function(opt)
  local find = opt.fargs[1]
  local replace = opt.fargs[2]
  vim.cmd("%s/" .. find .. "/" .. replace .. "/g")
end, { nargs = "*" })

create_command("Rr", function(opt)
  vim.cmd([[
		noh
	]])
end, {})

create_command("Break", function(opt)
  require("dap").toggle_breakpoint()
end, {})

create_command("ToggleTermV", function(opt)
  vim.cmd([[
		ToggleTerm direction=vertical size=75
	]])
end, {})
create_command("ToggleTermH", function(opt)
  vim.cmd([[
		ToggleTerm direction=horizontal size=15
	]])
end, {})

create_command("FaRP", function(opt)
  local find = opt.fargs[1]
  local replace = opt.fargs[2]
  local path = "./**/*"
  if opt.fargs[3] then
    path = opt.fargs[3]
  end
  vim.cmd("vimgrep " .. find .. " " .. path)
  vim.cmd("cfdo %s/" .. find .. "/" .. replace .. "/g")
end, { nargs = "*" })
