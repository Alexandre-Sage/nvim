local Plug = { "nvimdev/dashboard-nvim" }
Plug.dependencies = { { "nvim-tree/nvim-web-devicons" } }
Plug.event = "VimEnter"

function Plug.config()
  require("dashboard").setup({
    theme = "doom",
    -- preview = {
    -- 	command = require('telescope.builtin').find_files(), -- preview command
    -- 	file_path = ".",                                  -- preview file path
    -- 	file_height = 50,                                 -- preview file height
    -- 	file_width = 50                                   -- preview file width
    -- },
    config = {
      --header = {
      --	Desc = "Telescope",
      --	--action = require('telescope.builtin').find_files({ layout_config = { width = 0.2, height = 0.2 } })
      --},

      center = {
        {
          icon = " ",
          icon_hl = "Re Boot",
          desc = "Recover last session                 ",
          desc_hl = "String",
          key = "r",
          -- keymap = 'r',
          key_hl = "Number",
          key_format = "%s", -- remove default surrounding `[]`
          action = [[
						lua require("persistence").load({last = true})
					]],
        },
        {
          icon = " ",
          icon_hl = "Resume",
          desc = "Load directory last session          ",
          desc_hl = "String",
          key = "h",
          -- keymap = 'r',
          key_hl = "Number",
          key_format = "%s", -- remove default surrounding `[]`
          action = [[
						lua require("persistence").load()
					]],
        },
        {
          icon = " ",
          icon_hl = "Title",
          desc = "Find File                           ",
          desc_hl = "String",
          key = "f",
          -- 	keymap = 'SPC f f',
          key_hl = "Number",
          key_format = "%s", -- remove default surrounding `[]`
          action = [[
						lua require('telescope.builtin').find_files()
					]],
        },

        {
          icon = " ",
          icon_hl = "Title",
          desc = "Oil",
          desc_hl = "String",
          key = "o",
          -- 	keymap = 'SPC f f',
          key_hl = "Number",
          key_format = "%s", -- remove default surrounding `[]`
          action = [[
						lua require('oil').open()
					]],
        },
        --{
        --	icon = ' ',
        --	desc = 'Find Dotfiles',
        --	key = 'f',
        --	keymap = 'SPC f d',
        --	key_format = ' %s', -- remove default surrounding `[]`
        --	action = 'lua print(3)'
        --},
      },
    },
  })
end

return Plug
