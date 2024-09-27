local Plug = { "mfussenegger/nvim-dap" }

Plug.dependencies = {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
  -- stylua: ignore
  keys = {
    { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
    { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
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
  local dap = require("dap")
  local dapui = require("dapui")

  -- Setup dap-ui
  dapui.setup()
  local dap_debug = "/.local/js-debug/src/dapDebugServer.js"
  local dap_2 = "/.local/vscode-node-debug2/out/src/nodeDebugAdapter.js"
  -- Node.js adapter setup
  dap.adapters.node2 = {
    type = "executable",
    command = "node",
    args = { os.getenv("HOME") .. "/.local/js-debug/src/dapDebugServer.js" },
  }

  dap.adapters.node2_ts = {
    type = "executable",
    command = "node",
    args = { os.getenv("HOME") .. dap_2 },
  }

  dap.configurations.javascript = {
    {
      type = "node2",
      request = "launch",
      name = "Launch file",
      program = "${file}", -- Launch the current file
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      console = "integratedTerminal",
    },
    {
      type = "node2",
      request = "attach",
      name = "Attach to process",
      processId = require("dap.utils").pick_process,
      cwd = vim.fn.getcwd(),
    },
  }

  -- Debug configurations for TypeScript/ES6 modules
  dap.configurations.typescript = {
    {
      name = "Lanunch Node",
      type = "node2",
      request = "launch",
      runtimeArgs = { "-r", "ts-node/register" },
      runtimeExecutable = "node",
      args = { "--inspect", "${file}" },
      skipFiles = { "node_modules/**" },
      console = "integratedTerminal",
    },
    {
      type = "node2_ts",
      request = "attach",
      name = "Attach to TypeScript process",
      processId = require("dap.utils").pick_process,
      cwd = vim.fn.getcwd(),
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
  vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })

  vim.api.nvim_set_keymap("n", "<F5>", "<cmd>lua require'dap'.continue()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<F10>", "<cmd>lua require'dap'.step_over()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<F11>", "<cmd>lua require'dap'.step_into()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<F12>", "<cmd>lua require'dap'.step_out()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap(
    "n",
    "<leader>b",
    "<cmd>lua require'dap'.toggle_breakpoint()<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<leader>B",
    "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<leader>lp",
    "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.open()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<CR>", { noremap = true, silent = true })
  dap.set_log_level("DEBUG") -- Set log level to DEBUG for detailed logs

  -- Specify a log file (optional)
end

return Plug
