return {
  {
    name = "pwa-node",
    config = {
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
    },
  },
  {
    name = "firefox",
    config = {
      type = "executable",
      command = "node",
      args = {
        --	      os.getenv("HOME") .. "/.local/vscode-firefox-debug/dist/adapter.bundle.js"
        require("mason-registry").get_package("firefox-debug-adapter"):get_install_path() .. "/dist/adapter.bundle.js",
      },
    },
  },
  -- {
  --   name = "pwa-chrome",
  --   config = {
  --     type = "executable",
  --     command = "node",
  --     args = {
  --       require("mason-registry").get_package("chrome-debug-adapter"):get_install_path() .. "/out/src/chromeDebug.js", -- Use Mason's installed path
  --     },
  --   },
  -- },
}
