-- ---@class neotest
local Plug = { "nvim-neotest/neotest" }

Plug.dependencies = {
  "nvim-neotest/nvim-nio",
  "nvim-lua/plenary.nvim",
  "antoinemadec/FixCursorHold.nvim",
  "nvim-treesitter/nvim-treesitter",
  -- adapaters
  "marilari88/neotest-vitest",
  "nvim-neotest/neotest-jest",
  "arthur944/neotest-bun",
  -- "thenbe/neotest-playwright",
  "rouge8/neotest-rust",
  "nvim-neotest/neotest-plenary",
}
---@class neotest.Config
Plug.config = function()
  require("neotest").setup({
    log_level = vim.log.levels.TRACE,
    consumers = {
      -- require("neotest.consumers.watch"),
    },
    adapters = {
      require("neotest-jest")({}),
      require("neotest-plenary"),
      require("neotest-vitest"),
      require("neotest-bun"),
      -- require("neotest-playwright"),
      require("neotest-rust")({
        args = { "--nocapture" },
        -- dap_adapter = "rust-lldb",
        experimental = {
          test_table = true,
        },
        filter_dir = function(name, rel_path, root)
          if rel_path:match("^src/") then
            -- When filtering a single test, remove the `lib::` prefix assumption
            return nil -- fallback to default test binary behavior
          end
          return nil
        end,
        -- filter_dir = function(name, rel_path, root)
        --   -- allow discovery inside `tests/` and `src/`
        --   return name ~= "target" -- skip `target/`, include everything else
        -- end,
      }),
    },

    summary = {
      enabled = true,
      animated = true,
      -- open = "left | vertiacal resize 30",
      open = function()
        vim.cmd("vsplit") -- vertical split on the left
        vim.cmd("vertical resize 30") -- set width to 40 columns
        -- require("neotest").summary.open()
      end,
    },
  })
end

Plug.keys = {
  { "<leader>t", "", desc = "+test" },
  {
    "<space>tt",
    function()
      require("neotest").run.run(vim.fn.expand("%"))
    end,
    desc = "Run File (Neotest)",
  },
  {
    "<leader>tT",
    function()
      require("neotest").run.run(vim.uv.cwd())
    end,
    desc = "Run All Test Files (Neotest)",
  },
  {
    "<leader>tr",
    function()
      require("neotest").run.run()
    end,
    desc = "Run Nearest (Neotest)",
  },
  {
    "<leader>tl",
    function()
      require("neotest").run.run_last()
    end,
    desc = "Run Last (Neotest)",
  },
  {
    "<leader>ts",
    function()
      require("neotest").summary.toggle()
    end,
    desc = "Toggle Summary (Neotest)",
  },
  {
    "<leader>to",
    function()
      require("neotest").output.open({ enter = true, auto_close = true })
    end,
    desc = "Show Output (Neotest)",
  },
  {
    "<leader>tO",
    function()
      require("neotest").output_panel.toggle()
    end,
    desc = "Toggle Output Panel (Neotest)",
  },
  {
    "<leader>tS",
    function()
      require("neotest").run.stop()
    end,
    desc = "Stop (Neotest)",
  },
  {
    "<leader>tw",
    function()
      require("neotest").watch.toggle(vim.uv.cwd())
    end,
    desc = "Toggle Watch (Neotest)",
  },
}

return Plug
