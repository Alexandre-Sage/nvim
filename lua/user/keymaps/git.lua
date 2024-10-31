return {
  { { "n" }, "<leader>hs", require("gitsigns").stage_hunk, { desc = "Stage hunk" } },
  { { "n" }, "<leader>hr", require("gitsigns").reset_hunk, { desc = "Rest hunk" } },
  {
    { "n" },
    "<leader>hn",
    function()
      require("gitsigns").nav_hunk("next")
    end,
    { desc = "Next hunk" },
  },
  {
    { "n" },
    "<leader>hp",
    function()
      require("gitsigns").nav_hunk("prev")
    end,
    { desc = "Prev hunk" },
  },
  {
    { "v" },
    "<leader>hs",
    function()
      require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end,
  },
  {
    { "v" },
    "<leader>hr",
    function()
      require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end,
  },
  { { "n" }, "<leader>hS", require("gitsigns").stage_buffer, { desc = "Stage buffer" } },
  { { "n" }, "<leader>hu", require("gitsigns").undo_stage_hunk },
  { { "n" }, "<leader>hR", require("gitsigns").reset_buffer, { desc = "Reset buff" } },
  { { "n" }, "<leader>hP", require("gitsigns").preview_hunk },
  {
    { "n" },
    "<leader>hb",
    function()
      require("gitsigns").blame_line({ full = true })
    end,
  },
  { { "n" }, "<leader>tb", require("gitsigns").toggle_current_line_blame },
  { { "n" }, "<leader>hd", require("gitsigns").diffthis, { desc = "Git diff current file" } },
  {
    { "n" },
    "<leader>hD",
    function()
      require("gitsigns").diffthis("~")
    end,
    { desc = "Git diff current dir" },
  },
  { { "n" }, "<leader>td", require("gitsigns").toggle_deleted },
  { { "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>" },
}
