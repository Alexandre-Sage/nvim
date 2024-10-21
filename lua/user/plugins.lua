local lazy = {}

function lazy.install(path)
  if not vim.loop.fs_stat(path) then
    print("Installing lazy.nvim....")
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      path,
    })
  end
end

function lazy.setup(plugins)
  if vim.g.plugins_ready then
    return
  end

  -- You can "comment out" the line below after lazy.nvim is installed
  lazy.install(lazy.path)

  vim.opt.rtp:prepend(lazy.path)

  require("lazy").setup(plugins, lazy.opts)
  vim.g.plugins_ready = true
end

lazy.path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

lazy.setup({
  spec = {

    { import = "plugins" },
    { import = "plugins.lsp-plugs" },
    -- { import = "plugins.debugger" },
    { import = "plugins.utils" },
    { import = "plugins.ui" },
    { import = "plugins.git" },
    { import = "plugins.telescope.plug" },
    { import = "plugins.dap" },
    --    { import = "plugins.telescope.ui" },
    { import = "plugins.treesitter" },
    --		{ import = "plugins.dap" },
  },
})
