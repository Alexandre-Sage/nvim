local telescope = require("telescope")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local conf = require("telescope.config").values

-- Custom input function using Telescope
local function telescope_input(opts, callback)
  opts = opts
    or {
      preview = false,
      previewer = false,
      results_title = false,
      layout_strategy = "cursor",
      -- layout_config = {
      --
      -- }
    }

  pickers
    .new(opts, {
      layout_config = {
        height = 0.1,
        width = 0.3,
      },
      layout_strategy = "cursor",
      preview = false,
      previewer = false,
      results_title = false,
      prompt_title = opts.prompt_title or "Input",
      finder = finders.new_table({
        results = {},
        entry_maker = function(entry)
          return {
            display = entry,
            ordinal = entry,
            value = entry,
          }
        end,
      }),
      -- sorter = sorters.get_blank_sorter(),
      attach_mappings = function(prompt_bufnr, map)
        map("i", "<CR>", function()
          local entry = action_state.get_current_line()
          actions.close(prompt_bufnr)
          callback(entry)
        end)
        return true
      end,
    })
    :find()
end

-- Rename function
function Rename()
  local current_name = vim.fn.expand("<cword>")
  telescope_input({
    prompt_title = "Rename",
    default_text = current_name,
  }, function(new_name)
    if new_name and #new_name > 0 then
      vim.lsp.buf.rename(new_name)
    end
  end)
end

-- Optional: Bind this function to a keymap
require("helpers").map_key("n", "<space>rn", Rename, { noremap = true, silent = true })

-- local telescope = require("telescope")
-- local actions = require("telescope.actions")
-- local action_state = require("telescope.actions.state")
-- local finders = require("telescope.finders")
-- local pickers = require("telescope.pickers")
-- local sorters = require("telescope.sorters")
-- local conf = require("telescope.config").values
--
-- -- Custom input function using Telescope
-- local function telescope_input(opts, callback)
--   opts = opts or {}
--   local input = ""
--
--   pickers
--     .new(opts, {
--       prompt_title = opts.prompt_title or "Input",
--       finder = finders.new_table({
--         results = { opts.default_text or "" },
--         entry_maker = function(entry)
--           return {
--             display = entry,
--             ordinal = entry,
--             value = entry,
--           }
--         end,
--       }),
--       sorter = conf.generic_sorter(opts),
--       attach_mappings = function(prompt_bufnr, map)
--         map("i", "<CR>", function()
--           local entry = action_state.get_current_line()
--           actions.close(prompt_bufnr)
--           callback(entry)
--         end)
--         return true
--       end,
--     })
--     :find()
-- end
--
-- -- Rename function
-- function Rename()
--   local current_name = vim.fn.expand("<cword>")
--   telescope_input({
--     prompt_title = "Rename",
--     default_text = current_name,
--   }, function(new_name)
--     if new_name and #new_name > 0 then
--       vim.lsp.buf.rename(new_name)
--     end
--   end)
-- end
--
-- -- Optional: Bind this function to a keymap
-- vim.api.nvim_set_keymap("n", "<leader>rn", ":lua Rename()<CR>", { noremap = true, silent = true })
