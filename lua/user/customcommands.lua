local create_command = vim.api.nvim_create_user_command
local crate_buff_command = vim.api.nvim_buf_create_user_command
-- :execute "laddexpr '" . bufname() . ":" . line('.') . ":" . col('.') . ":Cursor position entry'"
crate_buff_command(0, "Upper", function(opts)
  print(string.upper(opts.fargs[1]))
end, { nargs = 1 })

create_command("Rr", function(opt)
  vim.cmd([[
		noh
	]])
end, {})
vim.keymap.set("n", "<leader>sl", function()
  vim.fn.setloclist(0, {
    {
      filename = vim.api.nvim_buf_get_name(0),
      lnum = vim.api.nvim_win_get_cursor(0)[1],
      col = vim.api.nvim_win_get_cursor(0)[2] + 1,
      text = "Cursor position entry",
    },
  }, "a")
end, { noremap = true, silent = true })
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
vim.api.nvim_create_user_command("MkNeorgWorkSpace", function()
  local home_dir = os.getenv("HOME")
  local neorg_wp_folder = "neorg-workspace"
  -- Prompt the user for input
  vim.ui.input({
    prompt = "Create neorg workspace: ",
    default = "", -- Optional default value
  }, function(input)
    -- Check if user provided input and didn't cancel
    if input and input ~= "" then
      -- Create the directory
      local path = home_dir .. "/" .. neorg_wp_folder .. "/" .. input
      local success = vim.fn.mkdir(path, "p")
      -- Show a notification based on success/failure
      if success == 1 then
        vim.cmd("edit " .. path .. "/" .. "index.norg")
        vim.cmd("write")
        vim.notify("Neorg workspace created: " .. input, vim.log.levels.INFO)
      else
        vim.notify("Failed to create Neorg workspace: " .. input, vim.log.levels.ERROR)
      end
    end
  end)
end, {})
