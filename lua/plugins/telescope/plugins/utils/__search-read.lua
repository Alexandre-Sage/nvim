local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

-- Custom function to read file content
local function read_selected_file(prompt_bufnr)
  local selection = action_state.get_selected_entry()
  actions.close(prompt_bufnr)
  local file_path = selection[1]
  vim.cmd("read " .. file_path)
end

-- Function to open file picker and read file content
local function open_file_picker()
  pickers
    .new({}, {
      prompt_title = "Select a file to read",
      finder = finders.new_oneshot_job({
        "fd",
        "--type",
        "f",
        "--hidden",
        "--no-ignore",
        "--exclude",
        ".git",
        "--exclude",
        "node_modules",
        "--exclude",
        "dist",
        "--exclude",
        "build",
      }, {}),
      sorter = conf.file_sorter({}),
      attach_mappings = function(_, map)
        map("i", "<CR>", read_selected_file)
        map("n", "<CR>", read_selected_file)
        return true
      end,
    })
    :find()
end

-- Map the function to a command or keybinding
require("helpers").map_key({ "n" }, "<leader>fR", open_file_picker, { desc = "Read file from picker" })
