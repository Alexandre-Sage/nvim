local map_key = require("helpers").map_key
local commands = require("plugins.telescope.commands")
local telescope_api = require("plugins.telescope.api")
local Plug = { "nvim-telescope/telescope.nvim" }
Plug.branch = "0.1.x"

Plug.dependencies = {
  { "nvim-lua/plenary.nvim" },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { "nvim-telescope/telescope-ui-select.nvim" },
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
        ["<C-d>"] = require("telescope.actions").delete_buffer,
      },
      i = {
        ["<C-d>"] = require("telescope.actions").delete_buffer,
      },
    },
  },
}
function Plug.init()
  local telescope = require("telescope.builtin")
  local themes = require("telescope.themes")
  local api = telescope_api(telescope, themes)
  commands(api)

  map_key({ "n" }, "<leader>ff", api.find_in_files, { noremap = true })

  map_key({ "n" }, "<c-f>", function()
    api.find_in_project({ no_ignore = true, hidden = true, file_ignore_patterns = { "node_modules" } })
  end, { noremap = true })

  map_key({ "n" }, "<leader>fc", api.find_in_current_file, { noremap = true })
  map_key({ "n" }, "<leader>b", api.opened_buffers, { noremap = true })
  map_key(
    { "n" },
    "<leader>dg",
    api.current_buffer_diagnostic,
    { noremap = true, desc = "Show LSP diag for current buffer" }
  )
  map_key({ "n", "v" }, "<leader>fr", api.lsp_references, { noremap = true })
  map_key({ "n", "v" }, "<leader>fd", api.lsp_definitions, { noremap = true })
  map_key({ "n" }, "<leader>fm", api.marks, { noremap = true })
  map_key({ "n" }, "<leader>rr", api.registers, { noremap = true })
  map_key({ "n" }, "<leader>nc", telescope.commands, { noremap = true })
  map_key({ "n" }, "<leader>pd", api.project_buffer_diagnostic, { noremap = true })
  require("telescope").load_extension("fzf")
  require("telescope").load_extension("ui-select")
end

return Plug
