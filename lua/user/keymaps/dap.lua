return {
  dap_ui = {
    {
      "<leader>du",
      function()
        require("dap-view").toggle(true)
      end,
      desc = "Dap UI",
    },
    {
      "<leader>de",
      function()
        require("dap-view").add_expr()
      end,
      desc = "Eval",
      mode = { "n", "v" },
    },
  },
  dap = {
    { "<leader>d", "", desc = "+debug", mode = { "n", "v" } },

    {
      "<leader>fDb",
      function()
        require("dap-utils").search_breakpoints({})
      end,
    },
    {
      "<leader>dlb",
      function()
        require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
      end,
      { desc = "Log break point" },
    },
    {
      "<leader>dB",
      function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end,
      desc = "Breakpoint Condition",
    },
    {
      "<leader>db",
      function()
        require("dap").toggle_breakpoint()
        local filename = vim.api.nvim_buf_get_name(0)
        local line_num = vim.api.nvim_win_get_cursor(0)[1]
        vim.fn.setloclist(0, {
          {
            filename = filename,
            lnum = line_num,
            col = vim.api.nvim_win_get_cursor(0)[2] + 1,
            text = "Breakpoint " .. filename .. " " .. line_num,
          },
        }, "a")
      end,
      desc = "Toggle Breakpoint",
    },
    {
      "<leader>dc",
      function()
        require("dap").continue()
      end,
      desc = "Continue",
    },
    -- {
    --   "<leader>da",
    --   function()
    --     require("dap").continue({ before = get_args })
    --   end,
    --   desc = "Run with Args",
    -- },
    {
      "<leader>dC",
      function()
        require("dap").run_to_cursor()
      end,
      desc = "Run to Cursor",
    },
    -- {
    --   "<leader>dg",
    --   function()
    --     require("dap").goto_()
    --   end,
    --   desc = "Go to Line (No Execute)",
    -- },
    {
      "<leader>di",
      function()
        require("dap").step_into()
      end,
      desc = "Step Into",
    },
    {
      "<leader>dj",
      function()
        require("dap").down()
      end,
      desc = "Down",
    },
    {
      "<leader>dk",
      function()
        require("dap").up()
      end,
      desc = "Up",
    },
    {
      "<leader>dl",
      function()
        require("dap").run_last()
      end,
      desc = "Run Last",
    },
    {
      "<leader>do",
      function()
        require("dap").step_out()
      end,
      desc = "Step Out",
    },
    {
      "<leader>dO",
      function()
        require("dap").step_over()
      end,
      desc = "Step Over",
    },
    {
      "<leader>dP",
      function()
        require("dap").pause()
      end,
      desc = "Pause",
    },
    {
      "<leader>dR",
      function()
        require("dap").restart()
      end,
      desc = "Toggle REPL",
    },
    {
      "<leader>dr",
      function()
        require("dap").repl.toggle()
      end,
      desc = "Toggle REPL",
    },
    {
      "<leader>ds",
      function()
        require("dap").session()
      end,
      desc = "Session",
    },
    {
      "<leader>dt",
      function()
        require("dap").terminate()
      end,
      desc = "Terminate",
    },
    {
      "<leader>dw",
      function()
        require("dap.ui.widgets").hover()
      end,
      desc = "Widgets",
    },
  },
}
