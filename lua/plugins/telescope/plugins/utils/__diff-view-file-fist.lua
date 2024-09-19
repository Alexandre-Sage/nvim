local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.config").values
local conf = require("telescope.config").values

-- Custom function to select file and show DiffviewFileHistory
local function telescope_diffview_picker()
  pickers
    .new({}, {
      prompt_title = "Find File for Diffview",
      finder = finders.new_oneshot_job({ "fd", "--type", "f" }, { hidden = true }), -- Use ripgrep (rg) to list files
      sorter = sorters.file_sorter({}),
      -- sorter = sorters.get_fuzzy_file(),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          local selected_entry = action_state.get_selected_entry()
          local file = selected_entry.value
          actions.close(prompt_bufnr)
          -- Call DiffviewFileHistory with the selected file
          vim.cmd("DiffviewFileHistory " .. file)
        end)
        return true
      end,
    })
    :find()
end

-- Define a keymap to trigger the custom picker
require("helpers").map_key({ "n" }, "<leader>fgh", telescope_diffview_picker, { desc = "" })
