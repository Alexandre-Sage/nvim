return {

  {
    { "n" },
    "<leader>cc",
    function()
      require("curl").open_curl_tab()
    end,
    { desc = "Open a curl tab scoped to the current working directory" },
  },

  {
    { "n" },
    "<leader>co",
    function()
      require("curl").open_global_tab()
    end,
    { desc = "Open a curl tab with gloabl scope" },
  },

  -- These commands will prompt you for a name for your collection
  {
    { "n" },
    "<leader>csc",
    function()
      require("curl").create_scoped_collection()
    end,
    { desc = "Create or open a collection with a name from user input" },
  },

  {
    { "n" },
    "<leader>cgc",
    function()
      require("curl").create_global_collection()
    end,
    { desc = "Create or open a global collection with a name from user input" },
  },

  {
    { "n" },
    "<leader>fsc",
    function()
      require("curl").pick_scoped_collection()
    end,
    { desc = "Choose a scoped collection and open it" },
  },

  {
    { "n" },
    "<leader>fgc",
    function()
      require("curl").pick_global_collection()
    end,
    { desc = "Choose a global collection and open it" },
  },
}
