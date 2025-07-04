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

-- vim.api.nvim_create_user_command("MkNeorgWorkSpace", function()
--   local home_dir = os.getenv("HOME")
--   local neorg_wp_folder = "neorg-workspace"
--   -- Prompt the user for input
--   vim.ui.input({
--     prompt = "Create neorg workspace: ",
--     default = "", -- Optional default value
--   }, function(input)
--     -- Check if user provided input and didn't cancel
--     if input and input ~= "" then
--       -- Create the directory
--       local path = home_dir .. "/" .. neorg_wp_folder .. "/" .. input
--       local success = vim.fn.mkdir(path, "p")
--       -- Show a notification based on success/failure
--       if success == 1 then
--         vim.cmd("edit " .. path .. "/" .. "index.norg")
--         vim.cmd("write")
--         vim.notify("Neorg workspace created: " .. input, vim.log.levels.INFO)
--       else
--         vim.notify("Failed to create Neorg workspace: " .. input, vim.log.levels.ERROR)
--       end
--     end
--   end)
-- end, {})
--
-- --
-- local function stream_command_to_buffer(ctx)
--   local cmd = ctx.args
--   local buf = vim.api.nvim_create_buf(false, true)
--   -- vim.cmd("split")
--
--   vim.bo.buftype = "nofile"
--   vim.bo.bufhidden = "wipe"
--   local win = vim.api.nvim_open_win(buf, false, { split = "above", height = 15 })
--   -- vim.api.nvim_win_set_buf(0, buf)
--
--   vim.fn.jobstart(cmd, {
--     stdout_buffered = false,
--     on_stdout = function(_, data, _)
--       if data then
--         vim.schedule(function()
--           local lines = vim.tbl_filter(function(line)
--             return line ~= ""
--           end, data)
--           if #lines > 0 then
--             vim.api.nvim_buf_set_lines(buf, -1, -1, false, lines)
--           end
--         end)
--       end
--     end,
--     on_stderr = function(_, data, _)
--       if data then
--         vim.schedule(function()
--           local lines = vim.tbl_filter(function(line)
--             return line ~= ""
--           end, data)
--           if #lines > 0 then
--             vim.api.nvim_buf_set_lines(buf, -1, -1, false, lines)
--           end
--         end)
--       end
--     end,
--   })
-- end
-- vim.api.nvim_create_user_command("Stream", stream_command_to_buffer, { nargs = "+", complete = "command" })
--
-- local function stream_shell_to_buffer(ctx)
--   vim.print(ctx)
--   local cmd = ctx.fargs
--   local buf = vim.api.nvim_create_buf(false, true)
--   -- vim.cmd("split")
--
--   vim.bo[buf].buftype = "nofile"
--   vim.bo[buf].bufhidden = "wipe"
--   vim.bo[buf].filetype = "zsh"
--   local win = vim.api.nvim_open_win(buf, false, { split = "above", height = 15 })
--
--   vim.system(cmd, {
--     stdout = function(err, data)
--       if data then
--         vim.schedule(function()
--           local lines = vim.split(data, "\n", { plain = true })
--           vim.api.nvim_buf_set_lines(buf, -1, -1, false, lines)
--           local line_count = vim.api.nvim_buf_line_count(buf)
--           vim.api.nvim_win_set_cursor(win, { line_count, 0 })
--         end)
--       end
--     end,
--     stderr = function(err, data)
--       if data then
--         vim.schedule(function()
--           local lines = vim.split(data, "\n", { plain = true })
--           vim.api.nvim_buf_set_lines(buf, -1, -1, false, lines)
--         end)
--       end
--     end,
--   })
-- end
-- vim.api.nvim_create_user_command("StreamS", stream_shell_to_buffer, { nargs = "+", complete = "command" })
--
-- local function otp(output_lines, data, _)
--   if type(data) == "table" then
--     for _, line in ipairs(data or {}) do
--       if line ~= "" then
--         table.insert(output_lines, line)
--
--         print(">> " .. line)
--
--         local file, lnum, col, text = line:match("^([^:]+):(%d+):(%d+):%s*(.+)")
--         if file and lnum and col and text then
--           vim.fn.setqflist({
--             {
--               filename = file,
--               lnum = tonumber(lnum),
--               col = tonumber(col),
--               text = text,
--               type = "E",
--             },
--           }, "a") -- append to existing qflist
--         end
--       end
--     end
--   end
-- end
-- local function stream_command_to_term(ctx)
--   vim.print(ctx)
--   local cmd = ctx.fargs
--   local buf = vim.api.nvim_create_buf(false, true)
--
--   vim.bo[buf].buftype = "nofile"
--   vim.bo[buf].bufhidden = "wipe"
--   vim.bo[buf].filetype = "zsh"
--   local win = vim.api.nvim_open_win(buf, false, { split = "above", height = 15 })
--   vim.api.nvim_set_current_win(win)
--   vim.api.nvim_set_current_buf(buf)
--
--   local output_lines = {}
--   local job_id = vim.fn.termopen(cmd, {
--
--     on_stdout = function(_, data, _)
--       otp(output_lines, _, data, _)
--     end,
--     on_exit = function(_, code, _)
--       vim.schedule(function()
--         print("Process finished with exit code " .. code)
--       end)
--     end,
--   })
--
--   vim.wo[win].relativenumber = true
--   vim.defer_fn(function()
--     local line_count = vim.api.nvim_buf_line_count(buf)
--     vim.api.nvim_win_set_cursor(win, { line_count, 0 })
--   end, 100)
--   vim.cmd("stopinsert")
--
--   return job_id
-- end
-- vim.api.nvim_create_user_command("StreamH", stream_command_to_term, {
--   nargs = "+",
--   complete = function()
--     return { "cargo watch -x test", "cargo watch -x build", "cargo watch -x run" }
--   end,
-- })
