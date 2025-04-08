local Plug = { "nvim-telescope/telescope.nvim" }
-- Plug.branch = "0.1.x"

Plug.dependencies = {
  { "nvim-lua/plenary.nvim" },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { "nvim-telescope/telescope-ui-select.nvim" },
  { "LukasPietzschmann/telescope-tabs" },
  { "Myzel394/jsonfly.nvim" },
}

Plug.cmd = { "Telescope" }

Plug.opts = {
  pickers = {
    current_buffer_fuzzy_find = {
      tiebreak = function(current_entry, existing_entry)
        return current_entry.lnum < existing_entry.lnum
      end,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
    ["ui-select"] = {
      require("telescope.themes").get_cursor({}),
    },
  },
  defaults = {
    path_display = { truncate = 2 }, --{ "filename_first", "shorten" },
    no_ignore = true,
    layout_config = {
      width = 0.9,
    },
    borderchars = {
      prompt = { " ", " ", "─", "│", "│", " ", "─", "└" },
      results = { "─", " ", " ", "│", "┌", "─", " ", "│" },
      preview = { "─", "│", "─", "│", "┬", "┐", "┘", "┴" },
    },
    mappings = {
      n = {
        ["<C-x>"] = require("telescope.actions").delete_buffer,
        ["C-d"] = require("telescope.actions").preview_scrolling_down,
        ["C-u"] = require("telescope.actions").preview_scrolling_up,
        ["<C-s>"] = require("telescope.actions").add_selection,
        -- ["C-s"] = require("telescope.actions.set").select,
        ["<C-l>"] = require("telescope.actions").send_selected_to_loclist,
        -- ["C-a"] = require("telescope.actions").send_to_qflist,
        -- ["C-s"] = require("telescope.actions").toggle_selection,
      },
      i = {
        ["<C-x>"] = require("telescope.actions").delete_buffer,
        -- ["C-q"] = require("telescope.actions").smart_add_to_qflist,
      },
    },
  },
}
function Plug.init()
  require("telescope").load_extension("fzf")
  require("telescope").load_extension("ui-select")
  require("telescope").load_extension("telescope-tabs")
  require("telescope").load_extension("jsonfly")
  require("helpers").parse_key_map(require("user.keymaps.telescope"))
end

return Plug
