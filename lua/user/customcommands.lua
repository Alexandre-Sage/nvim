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
vim.api.nvim_create_autocmd("FileType", {
  pattern = "aerial",
  callback = function()
    vim.wo.relativenumber = true -- Enable relative line numbers
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "curl",
  callback = function()
    vim.opt.switchbuf = "usetab"
  end,
})

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- :FormatDisable! disables autoformat for this buffer only
    vim.b.disable_autoformat = true
  else
    -- :FormatDisable disables autoformat globally
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true, -- allows the ! variant
})

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})
