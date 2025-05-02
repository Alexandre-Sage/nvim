local keymaps = require("user.keymaps.dap")
local Plug = { "mfussenegger/nvim-dap" }
-- require("dap-view").setup({ lsp = { enabled = true, completion = true, actions = true } })
Plug.dependencies = {
  {
    "igorlfs/nvim-dap-view",
    opts = {
      winbar = {
        sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl", "console" },
        controls = { enabled = true },
      },

      windows = {
        height = 17,
        terminal = {
          hide = { "typescript", "javascript", "typescriptreact" },
          position = "right",
          start_hidden = true,
          -- switchbuf = "newtab",
        },
      },
    },
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    opts = {
      debugger_path = "/home/adsoftware/vscode-js-debug",
      adapters = { "pwa-chrome", "node-terminal", "pwa-extensionHost" },
    },
    -- build = "git clone https://github.com/mxsdev/nvim-dap-vscode-js " .. os.getenv("HOME") .. "/.local/share/nvim/lazy",
  },
  { "niuiic/dap-utils.nvim" },
  { "LiadOz/nvim-dap-repl-highlights" },
  {
    "theHamsta/nvim-dap-virtual-text",
    opts = {
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = true,
      show_stop_reason = true,
      commented = false,
      -- Highlight groups for different elements
      virt_text_pos = "eol",
      all_frames = false,
      virt_lines = false,
      virt_text_win_col = nil,
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    enabled = false,
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
        pattern = { "dap-repl", "Dap-repl" },
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
  local dap = require("dap")
  -- local dapui = require("dapui")
  local dv = require("dap-view")

  for _, value in pairs(require("plugins.dap.adapters.index")) do
    dap.adapters[value.name] = value.config
  end
  for _, value in pairs(require("plugins.dap.config.index")) do
    dap.configurations[value.name] = value.config
  end
  dap.listeners.before.attach["dap-view-config"] = function()
    dv.open()
  end
  dap.listeners.before.launch["dap-view-config"] = function()
    dv.open()
  end
  -- dap.listeners.before.event_terminated["dap-view-config"] = function()
  --   dv.close()
  -- end
  -- dap.listeners.before.event_exited["dap-view-config"] = function()
  --   dv.close()
  -- end
  -- dap.listeners.after.event_initialized["dapui_config"] = function()
  --   dapui.open()
  -- end
  for _, sign in pairs(require("plugins.dap.commons.signs")) do
    vim.fn.sign_define(sign.name, sign.config)
  end
end

Plug.keys = keymaps.dap

return Plug
