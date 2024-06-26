local api = require("plugins.telescope.plugins.api")
local user_cmd = require("helpers").create_user_command
local map_key = require("helpers").map_key
local cmd = require("helpers").normal_cmd
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")

local function get_opts(diff)
  if diff then
    return {
      { "=> Revert hunk from: L-" .. diff[1] .. " to L-" .. diff[2], 1 },
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
  local diff = api.get_diff()
  pickers
    .new(opts, {
      prompt_title = "Git actions",
      finder = finders.new_table({
        results = get_opts(diff),
        entry_maker = api.make_entry,
      }),
      -- sorter = conf.generic_sorter(opts),
      attach_mappings = api.attach_mapping(diff),
    })
    :find()
end

user_cmd("GitActions", function()
  git_actions(require("telescope.themes").get_cursor({ layout_config = { anchor = "SE" } }))
end, "?")

map_key({ "v", "n" }, "<leader>Ga", cmd("GitActions"), { desc = "Toggle git actions for underline hunk or buffer" })

-- to execute the function
-- colors()
--return colors
