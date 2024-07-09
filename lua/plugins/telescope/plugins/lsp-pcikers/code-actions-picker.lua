local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

local function lsp_code_actions(opts)
  local params = vim.lsp.util.make_range_params()
  params.context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }
  local results_lsp = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
  local results = {}
  for x, res in pairs(results_lsp) do
    if res.result then
      for _, r in pairs(res.result) do
        table.insert(results, r)
      end
    end
  end
  -- for k, v in pairs(results) do
  --   v.idx = k
  -- end

  pickers
    .new(opts, {
      prompt_title = "LSP Code Actions",
      finder = finders.new_table({
        results = results,
        entry_maker = function(entry)
          require("helpers").log_to_file("./logt.txt", vim.inspect(entry))
          return {
            value = entry,
            display = entry.title,
            ordinal = entry.title,
            -- lnum = entry.idx,
          }
        end,
      }),
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        local execute_code_action = function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          vim.lsp.buf.execute_command(selection.value.command)
        end
        actions.select_default:replace(execute_code_action)
        return true
      end,
    })
    :find()
end
-- Map the function to a keybinding
require("helpers").map_key("n", "<leader>ca", function()
  lsp_code_actions(require("telescope.themes").get_cursor({
    --   layout_config = { anchor = "NO" },
    -- layout_strategy = "vertical",
  }))
end, { noremap = true, silent = true })
