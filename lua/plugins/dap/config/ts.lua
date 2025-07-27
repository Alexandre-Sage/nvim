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
        request = "launch",
        name = "Launch TS file (Watch & Restart)",
        program = function()
          -- The program will be your entry point, e.g., 'src/index.ts'
          -- You might want to be more specific than the current file for a full app
          return vim.fn.expand("%:p")
        end,
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        -- Change runtimeExecutable to ts-node-dev
        runtimeExecutable = "npx", -- Or the full path if npx isn't in your PATH
        -- Add arguments for ts-node-dev
        runtimeArgs = {
          "ts-node-dev",
          "--respawn", -- Keeps the process running and restarts it
          "--transpile-only", -- Speeds up restarts by skipping type checking on every change
          -- "--debug",         -- Useful for debugging ts-node-dev itself
          -- "--watch", "src", -- Optionally specify directories/files to watch
          -- "--clear",         -- Clears the terminal on restart
          -- Add any other ts-node-dev flags you need
        },
        envFile = function()
          local cwd = vim.fn.getcwd()
          return cwd .. "/.env"
        end,
        console = "integratedTerminal",
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch TS file (Node 24 --watch)",
        program = function()
          -- This should point to your main TypeScript entry file (e.g., 'src/index.ts')
          -- If your program is a single file, vim.fn.expand("%:p") works.
          -- For larger projects, you might hardcode the entry point, e.g., 'src/main.ts'
          return vim.fn.expand("%:p")
        end,
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        runtimeExecutable = "node", -- Crucially, use the native 'node' executable
        runtimeArgs = {
          "--watch", -- Enable Node.js's native watch mode
          "--experimental-watch", -- (Optional, good practice for newer features in watch)
          "-r",
          "ts-node/register", -- Register ts-node to transpile TS files on the fly
          -- If you encounter issues with source maps, you might need:
          -- "--enable-source-maps",
        },
        args = {
          -- Pass the program file as an argument to Node.js after the runtimeArgs
          -- This is the file that Node will execute, and ts-node/register will handle it.
          vim.fn.expand("%:p"),
        },
        envFile = function()
          local cwd = vim.fn.getcwd()
          return cwd .. "/.env"
        end,
        console = "integratedTerminal",
        -- Important: For --watch, set "restart" to true so DAP client automatically reconnects
        restart = true,
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
        args = {
          "--no-remote", -- Essential for debugging to ensure a new instance
          "-P",
          "default-release", -- Use your main profile named "default-release"
          -- OR, to create/use a dedicated debug profile:
          -- "-P", "dap-debug-profile",
          -- OR, to specify a direct path to a profile directory:
          -- "-profile", "/path/to/your/custom/profile/directory",
        },
        sourceMaps = true,
        -- profile = "default-release",
      },
      {
        name = "Attach to Firefox",
        type = "firefox",
        request = "attach",
        url = "http://localhost:3000", -- Adjust if your app runs on a different port
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
