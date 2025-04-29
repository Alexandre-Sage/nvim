return {
  name = "lua_ls",
  opts = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            -- Add plenary.nvim to the workspace library
            vim.fn.stdpath("data") .. "/lazy/plenary.nvim/lua",
          },
          checkThirdParty = false, -- Avoid prompting for third-party libraries
        },
      },
    },
  },
}
