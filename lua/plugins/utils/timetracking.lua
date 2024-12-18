local Plug = {

  "3rd/time-tracker.nvim",
  dependencies = {
    "3rd/sqlite.nvim",
  },
}

Plug.opts = {
  data_file = "/home/adsoftware/time-tracker.sqlite3",
  tracking_events = { "BufEnter", "BufWinEnter", "CursorMoved", "CursorMovedI", "WinScrolled" },
  tracking_timeout_seconds = 3 * 60 * 60,
}

return Plug
