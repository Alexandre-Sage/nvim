local user_cmd = require("helpers").create_user_command
local map_key = require("helpers").map_key
local cmd = require("helpers").normal_cmd
local log = require("helpers").log_to_file
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local git = require("gitsigns")
local function is_current_line_in_git_diff(bufnr)
  -- Get the current buffer and line number
  local lnum = vim.api.nvim_win_get_cursor(0)[1]

  -- Get the hunks for the current buffer
  local hunks = require("gitsigns").get_hunks(bufnr)
  if not hunks then
    return false
  end

  -- Check if the current line is part of any hunk
  for _, hunk in ipairs(hunks) do
    if lnum >= hunk.added.start and lnum <= hunk.added.start + hunk.added.count - 1 then
      return { hunk.added.start, hunk.added.start + hunk.added.count - 1 }
    end
    if lnum >= hunk.removed.start and lnum <= hunk.removed.start + hunk.removed.count - 1 then
      return { hunk.removed.start, hunk.removed.start + hunk.removed.count - 1 }
    end
  end

  return false
end

local function get_opts(diff)
  if diff then
    return {
      { "Revert hunk", 1 },
      { "Stage hunk", 2 },
      { "Next hunk", 3 },
      { "Previous hunk", 4 },
    }
  else
    return {
      { "Next hunk", 3, 1 },
      { "Previous hunk", 4, 2 },
    }
  end
end

local git_actions = function(opts)
  opts = opts or {}
  local bufnr = vim.api.nvim_get_current_buf()
  local diff = is_current_line_in_git_diff(bufnr)
  pickers
    .new(opts, {
      prompt_title = "Git actions",
      finder = finders.new_table({
        results = get_opts(diff),
        entry_maker = function(entry)
          log("/home/adsoftware/logs/ga.log", entry[1])
          return {
            value = entry[2],
            display = entry[1],
            ordinal = entry[3] or entry[2],
            lnum = entry[3] or entry[2],
          }
        end,
      }),
      -- sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          print(selection)
          if selection.value == 1 then
            git.reset_hunk(diff)
          elseif selection.value == 2 then
            git.stage_hunk(diff)
          elseif selection.value == 3 then
            git.nav_hunk("next")
          elseif selection.value == 4 then
            git.nav_hunk("prev")
          end
        end)
        return true
      end,
    })
    :find()
end

user_cmd("GitActions", function()
  git_actions(require("telescope.themes").get_dropdown({}))
end, "?")

map_key({ "v", "n" }, "<leader>ga", cmd("GitActions"), { desc = "Toggle git actions for underline hunk or buffer" })

-- to execute the function
-- colors()
--return colors
