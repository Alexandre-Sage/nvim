local Plug = { "mfussenegger/nvim-dap" }

Plug.dependencies = {

  { "jay-babu/mason-nvim-dap.nvim" },
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
      runtimeExecutable = "node",
      runtimeArgs = {
        "-r",
        os.getenv("HOME")
          .. "/.nvm/versions/node/"
          .. vim.fn.system("node -v"):gsub("%s+", "")
          .. "/lib/node_modules/ts-node/register",
      }, -- Use ts-node for TypeScript

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
