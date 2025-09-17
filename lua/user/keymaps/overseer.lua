return {
  { { "n" }, "<C-p>", require("overseer").run_template, { desc = "Run overseer tasks" } },
  -- { { "n" }, "<C-T>", require("overseer.component").open_output, { desc = "Open overseer output" } },
  {
    { "n" },
    "<C-o>",
    function()
      require("overseer").toggle({
        direction = "left",
      })
    end,
    { desc = "Toggle overseer" },
  },
}
