local keymaps = require("plugins.dap.commons.keymaps")
local Plug = { "mfussenegger/nvim-dap" }
Plug.dependencies = {
  { "niuiic/dap-utils.nvim" },
  { "theHamsta/nvim-dap-virtual-text" },
  { "jay-babu/mason-nvim-dap.nvim" },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    keys = keymaps.dap_ui,
    opts = {
      layouts = require("plugins.dap.commons.layout"),
    },
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "Dap-repl",
        callback = function()
          local cmp = require("cmp")
          cmp.setup.buffer({
            sources = {
              { name = "nvim_lsp" }, -- Enable LSP completion
              { name = "buffer" }, -- Optionally, add buffer completion
            },
          })
        end,
      })
    end,
  },
  "nvim-neotest/nvim-nio",
}

function Plug.config()
  require("mason-nvim-dap").setup({
    ensure_installed = { "node-debug2-adapter", "js-debug-adapter" },
    automatic_installation = true,
    handlers = nil,
  })
  local dap = require("dap")
  local dapui = require("dapui")

  for _, value in pairs(require("plugins.dap.adapters.js-ts")) do
    dap.adapters[value.name] = value.config
  end
  for _, value in pairs(require("plugins.dap.config.index")) do
    dap.configurations[value.name] = value.config
  end
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  for _, sign in pairs(require("plugins.dap.commons.signs")) do
    vim.fn.sign_define(sign.name, sign.config)
  end
end

Plug.keys = keymaps.dap

return Plug
