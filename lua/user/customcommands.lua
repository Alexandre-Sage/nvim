local create_command = vim.api.nvim_create_user_command
local crate_buff_command = vim.api.nvim_buf_create_user_command
crate_buff_command(0, "Upper", function(opts)
  print(string.upper(opts.fargs[1]))
end, { nargs = 1 })

create_command("Rr", function(opt)
  vim.cmd([[
		noh
	]])
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
