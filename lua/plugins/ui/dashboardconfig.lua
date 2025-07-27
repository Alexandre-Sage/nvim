local Plug = { "nvimdev/dashboard-nvim", enabled = true }
Plug.dependencies = { { "nvim-tree/nvim-web-devicons" } }
Plug.event = "VimEnter"
Plug.opts = {
  theme = "doom",
  config = {
    header = {
      [[]],
      [[]],
      [[]],
      [[]],
      [[{___     {__                    {__         {__                ]],
      [[{_ {__   {__                     {__       {__  {_             ]],
      [[{__ {__  {__   {__       {__      {__     {__     {___ {__ {__ ]],
      [[{__  {__ {__ {_   {__  {__  {__    {__   {__   {__ {__  {_  {__]],
      [[{__   {_ {__{_____ {__{__    {__    {__ {__    {__ {__  {_  {__]],
      [[{__    {_ __{_         {__  {__      {____     {__ {__  {_  {__]],
      [[{__      {__  {____      {__          {__      {__{___  {_  {__]],
      [[]],
      [[]],
      [[]],
      [[]],
    },
    center = {
      -- {
      --   icon = "󱄋 ",
      --   icon_hl = "Re Boot",
      --   desc = "Recover last session                 ",
      --   desc_hl = "String",
      --   key = "r",
      --   -- keymap = 'r',
      --   key_hl = "Number",
      --   key_format = "%s", -- remove default surrounding `[]`
      --   action = [[
      -- 	lua require("persistence").load({last = true})
      -- ]],
      -- },
      --   {
      --     icon = "󰸨 ",
      --     icon_hl = "Resume",
      --     desc = "Load directory last session          ",
      --     desc_hl = "String",
      --     key = "h",
      --     -- keymap = 'r',
      --     key_hl = "Number",
      --     key_format = "%s", -- remove default surrounding `[]`
      --     action = [[
      -- lua require("persistence").load()
      --  ]],
      --   },
      {
        icon = "󰮗 ",
        icon_hl = "Title",
        desc = "Find File                           ",
        desc_hl = "String",
        key = "f",
        -- 	keymap = 'SPC f f',
        key_hl = "Number",
        key_format = "%s", -- remove default surrounding `[]`
        action = [[
      lua require('telescope.builtin').find_files({ no_ignore = true, hidden = true, file_ignore_patterns = { ".git", "node_modules", "dist", "build", "target" }, })
       ]],
      },

      {
        icon = "󰜏 ",
        icon_hl = "Title",
        desc = "Live Grep                           ",
        desc_hl = "String",
        key = "l",
        -- 	keymap = 'SPC f f',
        key_hl = "Number",
        key_format = "%s", -- remove default surrounding `[]`
        action = [[
      lua require('telescope.builtin').live_grep({ no_ignore = true, hidden = true, file_ignore_patterns = { "node_modules" } })
       ]],
      },
      {
        icon = "󱏒 ",
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
      {

        icon = " ",
        icon_hl = "Title",
        desc = "NeoGit",
        desc_hl = "String",
        key = "n",
        -- 	keymap = 'SPC f f',
        key_hl = "Number",
        key_format = "%s", -- remove default surrounding `[]`
        action = [[
      	Neogit
      ]],
      },
      {
        icon = " ",
        icon_hl = "Title",
        desc = "Databases",
        desc_hl = "String",
        key = "d",
        -- 	keymap = 'SPC f f',
        key_hl = "Number",
        key_format = "%s", -- remove default surrounding `[]`
        action = [[
      	DBUI
      	wincmd l
      	q
      ]],
      },
      {
        icon = "󰢩 ",
        icon_hl = "Title",
        desc = "Curl",
        desc_hl = "String",
        -- key = "c",
        -- 	keymap = 'SPC f f',
        key_hl = "Number",
        key_format = "%s", -- remove default surrounding `[]`
        --        action = [[
        -- 	CurlOpen
        -- ]],
      },
      {
        icon = "  󱞪  ",
        icon_hl = "Title",
        desc = "Current project",
        desc_hl = "String",
        key = "c",
        -- 	keymap = 'SPC f f',
        key_hl = "Number",
        key_format = "%s", -- remove default surrounding `[]`
        action = [[
      	CurlOpen
      ]],
      },
      {
        icon = "  󱞪  ",
        icon_hl = "Title",
        desc = "Open global collection",
        desc_hl = "String",
        key = "cg",
        -- 	keymap = 'SPC f f',
        key_hl = "Number",
        key_format = "%s", -- remove default surrounding `[]`
        action = [[
      lua	      require("curl").pick_global_collection()

      	]],
      },
    },
  },
}

return Plug
