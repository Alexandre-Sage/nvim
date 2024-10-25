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
        runtimeArgs = {
          -- "--inspect-brk",
        },
        -- outFiles = {
        --   "${workspaceFolder}/dist/**/*.js",
        --   "${workspaceFolder}/build/**/*.js",
        -- },
        console = "integratedTerminal",
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
        type = "pwa-chrome",
        name = "Chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}",
      },
    },
  },
}
