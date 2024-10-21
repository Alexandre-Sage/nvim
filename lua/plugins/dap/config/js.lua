return {
  {
    name = "javascript",
    config = {
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
    },
  },
}
