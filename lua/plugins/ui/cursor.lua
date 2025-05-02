local Plug = { "sphamba/smear-cursor.nvim" }

Plug.opts = {
  -- cursor_color = "#00fff7",
  cursor_color = "#d0ff00",
  stiffness = 0.3,
  trailing_stiffness = 0.1,
  trailing_exponent = 5,
  never_draw_over_target = true,
  hide_target_hack = true,
  gamma = 1,
}

return Plug
