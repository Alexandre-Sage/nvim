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

vim.api.nvim_create_user_command("HardReset", function()
  local terms = require("toggleterm.terminal").get_all()
  if #terms >= 1 then
    terms:map(function(term)
      term:shutdown()
    end)
  end

  vim.cmd("bufdo bwipeout")
  vim.cmd("tabonly")
  vim.cmd("only")
  vim.cmd("cd " .. vim.g.initial_cwd) -- Or use vim.g.initial_cwd if you save it on startup
  vim.cmd("Dashboard")
  -- require("dashboardconfig")
end, {})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.g.initial_cwd = vim.fn.getcwd()
  end,
  desc = "Save the initial working directory on startup",
})
vim.api.nvim_create_user_command("InsertEnv", function(opts)
  local varname = opts.args
  local value = os.getenv(varname) or ""
  vim.api.nvim_put({ value }, "c", true, true)
end, {
  nargs = 1,
  complete = function(_, _, _)
    -- Optional: show list of env vars for tab completion
    local env = vim.fn.environ()
    local keys = {}
    for k, _ in pairs(env) do
      table.insert(keys, k)
    end
    return keys
  end,
})
