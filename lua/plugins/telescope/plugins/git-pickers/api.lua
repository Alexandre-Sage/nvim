local git = require("gitsigns")
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local helpers = require("helpers")

local function highlight_text(bufnr, start_line, end_line)
  local ns_id = vim.api.nvim_create_namespace("GitActions")
  -- vim.api.nvim_buf_set_extmark(bufnr, ns_id, start_line, 0, { end_row = 10, end_col = 10, hl_group = "MyHighlight" })
  vim.api.nvim_buf_add_highlight(0, ns_id, "NeogitChangeModified", 10, 0, 5)
end

local function is_current_line_in_git_diff(bufnr)
  local lnum = vim.api.nvim_win_get_cursor(0)[1]
  local hunks = git.get_hunks(bufnr)

  if not hunks then
    return false
  end

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

local function make_entry(entry)
  return {
    value = entry[2],
    display = entry[1],
    ordinal = entry[3] or entry[2],
    lnum = entry[3] or entry[2],
  }
end

local function attach_mapping(diff)
  return function(prompt_bufnr, map)
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
  end
end
local function get_diff()
  local bufnr = vim.api.nvim_get_current_buf()
  local is_diff = is_current_line_in_git_diff(bufnr)
  if is_diff then
    highlight_text(bufnr, is_diff[1], is_diff[2])
  end
  return is_diff
end
return {
  make_entry = make_entry,
  attach_mapping = attach_mapping,
  get_diff = get_diff,
  is_current_line_in_git_diff = is_current_line_in_git_diff,
}
