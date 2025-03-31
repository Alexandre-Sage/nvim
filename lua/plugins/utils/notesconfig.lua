local Plug = { "gsuuon/note.nvim", lazy = true }
Plug.opts = {
  spaces = {
    "~",
  },
}
Plug.keys = {
  -- You can use telescope to search the current note space:
  {
    "<leader>tn", -- [t]elescope [n]ote
    function()
      require("telescope.builtin").live_grep({
        cwd = require("note.api").current_note_root(),
      })
    end,
    mode = "n",
  },
}

Plug.cmd = "Note"
Plug.ft = "note"
return Plug
