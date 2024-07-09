local map_key = require("helpers").map_key
local commands = require("plugins.telescope.commands")
local telescope_api = require("plugins.telescope.api")
local Plug = { "nvim-telescope/telescope.nvim" }

Plug.branch = "0.1.x"

Plug.dependencies = {
  { "nvim-lua/plenary.nvim" },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
}

Plug.cmd = { "Telescope" }

function Plug.init()
  local utils = require("telescope.utils")
  local telescope = require("telescope.builtin")
  local themes = require("telescope.themes")
  local api = telescope_api(telescope, themes)
  commands(api)

  map_key({ "n" }, "<C-p>", api.find_in_files, { noremap = true })
  map_key({ "n" }, "<leader>ff", api.find_in_files, { noremap = true })

  map_key({ "n" }, "<c-f>", function()
    api.find_in_project({ no_ignore = true, hidden = true, file_ignore_patterns = { "node_modules" } })
  end, { noremap = true })

  map_key({ "n" }, "<leader>fc", api.find_in_current_file, { noremap = true })
  map_key({ "n" }, "<leader>b", api.opened_buffers, { noremap = true })
  map_key(
    { "n" },
    "<leader>sd",
    api.current_buffer_diagnostic,
    { noremap = true, desc = "Show LSP diag for current buffer" }
  )
  map_key({ "n" }, "<leader>fd", api.lsp_references, { noremap = true })
  map_key({ "n" }, "<A-d>", api.lsp_definitions, { noremap = true })
  map_key({ "n" }, "<leader>m", api.marks, { noremap = true })
  map_key({ "n" }, "<leader>r", api.registers, { noremap = true })
  map_key({ "n" }, "<leader>gc", telescope.git_commits, { noremap = true })
  map_key({ "n" }, "<leader>gb", telescope.git_branches, { noremap = true })
  map_key({ "n" }, "<leader>nc", telescope.commands, { noremap = true })
  require("telescope").load_extension("fzf")
end

Plug.opts = {
  pickers = {
    find_files = {
      layout_strategy = "vertical",
      layout_config = {
        width = 0.9,
        height = 0.9,
      },
      theme = "dropdown",
      width = 0.9,
      height = 0.9,
    },
    lsp_references = {
      layout_strategy = "vertical",
      layout_config = { width = 0.9, height = 0.9 },
      path_display = {
        "smart",
      },
      width = 0.9,
      height = 0.9,
    },
    current_buffer_fuzzy_find = {
      tiebreak = function(current_entry, existing_entry)
        return current_entry.lnum < existing_entry.lnum
      end,
    },
    -- registers = {

    --   theme = "cursor",
    -- },
    --live_grep = {
    --	theme = "dropdown",
    --}
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
  defaults = {
    -- Default configuration for telescope goes here:
    path_display = { truncate = 2 }, --{ "filename_first", "shorten" },
    layout_config = {
      width = 0.9,
      -- bottom_pane = {
      --   height = 25,
      --   preview_cutoff = 120,
      --   prompt_position = "top",
      --   width = 100,
      -- },
      -- center = {
      --   height = 0.4,
      --   preview_cutoff = 40,
      --   prompt_position = "top",
      --   width = 100,
      -- },
      -- cursor = {
      --   height = 0.9,
      --   preview_cutoff = 40,
      --   width = 100,
      -- },
      -- horizontal = {
      --   height = 0.9,
      --   preview_cutoff = 120,
      --   prompt_position = "bottom",
      --   width = 100,
      -- },
      -- vertical = {
      --   height = 0.9,
      --   preview_cutoff = 40,
      --   prompt_position = "bottom",
      --   width = 0.9,
      -- },
    },
    -- ..
  },
}

return Plug

-- local builtin = require("telescope.builtin")
-- local utils = require("telescope.utils")
--
-- ["<leader>ff"] = { function() builtin.find_files({ cwd = utils.buffer_dir() }) end,
--       desc = "Find files in cwd" }
