return {
  {
    name = "typescript",
    config = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch TS file",
        program = function()
          return vim.fn.expand("%:p") -- Launch the current file
        end,
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        runtimeExecutable = "/usr/bin/ts-node",
        envFile = function()
          local cwd = vim.fn.getcwd() -- Get the current working directory
          return cwd .. "/.env" -- Assuming each project has its own .env file
        end,
        runtimeArgs = {},
        console = "integratedTerminal",
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach process",
        processId = require("dap.utils").pick_process,
      },
    },
  },
  {
    name = "typescriptreact",
    config = {
      {
        name = "Debug with Firefox",
        type = "firefox",
        request = "launch",
        reAttach = true,
        url = "http://localhost:3000",
        webRoot = "${workspaceFolder}",
        firefoxExecutable = "/usr/bin/firefox",
        sourceMaps = true,
      },
      {
        name = "Attach to Firefox",
        type = "firefox",
        request = "attach",
        url = "http://localhost:8080", -- Adjust if your app runs on a different port
        webRoot = "${workspaceFolder}",
        port = 9222, -- Default port for Firefox remote debugging
        sourceMaps = true,
        trace = true, -- Optional: enables tracing for more detailed logs
      },

      {
        name = "Debug with Chromium",
        type = "pwa-chrome", -- Use 'pwa-chrome' for Chromium
        request = "launch",
        url = "http://localhost:8080", -- Adjust if your app runs on a different port
        webRoot = "${workspaceFolder}",
        sourceMaps = true,
        trace = true, -- Optional: enables tracing for more detailed logs
        runtimeExecutable = "/bin/chromium", -- Path to your Chromium executable
      },
      {
        name = "Attach to Chromium",
        type = "pwa-chrome",
        request = "attach",
        port = 9222, -- Port for remote debugging
        webRoot = "${workspaceFolder}",
        sourceMaps = true,
        protocol = "inspector",
      },
    },
  },
}
