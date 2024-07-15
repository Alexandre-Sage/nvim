local telescope = require("telescope")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local previewers = require("telescope.previewers")
local conf = require("telescope.config").values

local function search_in_selected_folder(folder)
  if not folder then
    print("No folder selected. Please select a folder first.")
    return
  end

  local opts = {}
  opts.search_dirs = { folder }

  require("telescope.builtin").live_grep(opts)
end

local function select_folder()
  local opts = {}
  pickers
    .new(opts, {
      prompt_title = "Select Folder",
      finder = finders.new_oneshot_job({ "find", ".", "-type", "d" }, opts),
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          -- Automatically open the fuzzy finder to search in the selected folder
          search_in_selected_folder(selection[1])
        end)
        return true
      end,
    })
    :find()
end

-- Set up keybindings or commands to call the functions
require("helpers").map_key({ "n" }, "<leader>fs", select_folder, { desc = "" })
