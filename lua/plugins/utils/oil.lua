local helpers = require("helpers")
local language_specific_hidden = { "node_modules", "target" }
local Plug = { "stevearc/oil.nvim" }
Plug.dependencies = { "nvim-tree/nvim-web-devicons" }
Plug.opts = {
  lsp_file_methods = {
    timeout_ms = 1000,
    autosave_changes = false,
  },
  view_options = {
    is_hidden_file = function(name, _)
      return language_specific_hidden[name] -- vim.startswith(name, ".")
    end,
    is_always_hidden = function(name, _)
      return name == ".git"
    end,
  },
}

Plug.opts.keymaps = {
  ["<c-p>"] = { "actions.preview", opts = { split = "right" } },
  ["<leader>fo"] = function()
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    require("telescope.builtin").find_files({
      find_command = { "fd", "--type", "d" },
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          local selected_entry = action_state.get_selected_entry()
          local path = selected_entry.path or selected_entry.filename or selected_entry[1]
          actions.close(prompt_bufnr)
          if vim.fn.isdirectory(path) == 1 then
            require("oil").open(path)
          else
            vim.cmd("edit " .. path)
          end
        end)
        return true
      end,
    })
  end,
}

function Plug.init()
  local oil = require("oil")
  helpers.map_key({ "n" }, "<leader>O", function()
    oil.open(vim.fn.getcwd())
  end, { desc = "Open oil buffer" })
  helpers.map_key({ "n" }, "<leader>o", oil.toggle_float, { desc = "Toogle oil pop up" })
end

return Plug
