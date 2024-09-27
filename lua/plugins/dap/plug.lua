local Plug = { "mfussenegger/nvim-dap" }
local function load_env_file()
  local env_path = vim.fn.getcwd() .. "/.env"
  local env_file = io.open(env_path, "r")

  if env_file then
    for line in env_file:lines() do
      local key, value = line:match("([^=]+)=([^=]+)")
      if key and value then
        vim.fn.setenv(key, value)
      end
    end
    env_file:close()
  end
end
Plug.dependencies = {

  { "jay-babu/mason-nvim-dap.nvim" },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    keys = {
      {
        "<leader>du",
        function()
          require("dapui").toggle({})
        end,
        desc = "Dap UI",
      },
      {
        "<leader>de",
        function()
          require("dapui").eval()
        end,
        desc = "Eval",
        mode = { "n", "v" },
      },
    },
    opts = {},
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
  },
  "nvim-neotest/nvim-nio",
}

function Plug.config()
  require("mason-nvim-dap").setup({
    ensure_installed = { "node-debug2-adapter", "js-debug-adapter" },
    automatic_installation = true,
  })
  local dap = require("dap")
  local dapui = require("dapui")
  dap.set_log_level("TRACE")
  -- Setup dap-ui
  dapui.setup()
  local dap_debug = "/.local/js-debug/src/dapDebugServer.js"
  local dap_2 = "/.local/vscode-node-debug2/out/src/nodeDebugAdapter.js"
  dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = "node",
      args = {
        require("mason-registry").get_package("js-debug-adapter"):get_install_path()
          .. "/js-debug/src/dapDebugServer.js", -- Use Mason's installed path
        "${port}",
      },
    },
  }

  -- Debug Configurations for JavaScript
  dap.configurations.javascript = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch JS file",
      program = function()
        return vim.fn.expand("%:p") -- Launch the current file
      end,
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      console = "integratedTerminal",
    },
  }
  -- Debug Configurations for TypeScript
  dap.configurations.typescript = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch TS file",
      program = function()
        return vim.fn.expand("%:p") -- Launch the current file
      end,
      cwd = vim.fn.getcwd(),
      sourceMaps = false,
      protocol = "inspector",
      runtimeExecutable = "/usr/bin/ts-node",
      -- env = {
      -- },
      before_setup = function()
        load_env_file() -- Load the .env file before launching the debugger
      end,
      runtimeArgs = {}, -- Use ts-node for TypeScript

      console = "integratedTerminal",
    },
  }
  -- Automatically open and close dap-ui
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end

  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end

  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end

  -- Key mappings for debugging

  vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })
  vim.fn.sign_define(
    "DapBreakpointCondition",
    { text = "", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
  )
  vim.fn.sign_define(
    "DapBreakpointRejected",
    { text = "", texthl = "DapBreakpointRejected", linehl = "", numhl = "" }
  )
  vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "", numhl = "" })
  vim.fn.sign_define("DapStopped", { text = "➡️", texthl = "DapStopped", linehl = "➡️", numhl = "➡️" })
  dap.set_log_level("DEBUG") -- Set log level to DEBUG for detailed logs
end

Plug.keys = {
  { "<leader>d", "", desc = "+debug", mode = { "n", "v" } },
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
  {
    "<leader>dg",
    function()
      require("dap").goto_()
    end,
    desc = "Go to Line (No Execute)",
  },
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
    "<leader>dp",
    function()
      require("dap").pause()
    end,
    desc = "Pause",
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
}

return Plug
