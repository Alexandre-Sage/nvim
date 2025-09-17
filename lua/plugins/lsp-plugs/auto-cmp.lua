local Plug = { "hrsh7th/nvim-cmp" }
Plug.dependencies = {
  { "Alexandre-Sage/curl-nvim-cmp" },
  { "hrsh7th/cmp-cmdline" },
  { "SergioRibera/cmp-dotenv" },
  { "rcarriga/cmp-dap" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "saadparwaiz1/cmp_luasnip" },
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        local luasnip = require("luasnip")
        require("luasnip.loaders.from_vscode").load({
          -- include = { "typescript", "typescriptreact" },
        })
        require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
        luasnip.filetype_extend("rust", { "rust" })
        luasnip.filetype_extend("toml", { "toml" })
        luasnip.filetype_extend("typescript", { "typescript", "javascript" })
        luasnip.filetype_extend("typescriptreact", { "javascript", "typescript" })

        vim.keymap.set({ "i", "n" }, "<C-s>", function()
          luasnip.expand({})
        end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<Tab>", function()
          if require("luasnip").jumpable(1) then
            return "<Plug>luasnip-jump-next"
          else
            return "<Tab>"
          end
        end, { expr = true })

        vim.keymap.set({ "i", "s" }, "<C-a>", function()
          if require("luasnip").jumpable(-1) then
            return "<Plug>luasnip-jump-prev"
          else
            return "<S-Tab>"
          end
        end, { expr = true })
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
  }, -- Ensure LuaSnip build step is here
}

Plug.event = "InsertEnter"

function Plug.config()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  local compare = cmp.config.compare
  -- require("luasnip.loaders.from_vscode").load({
  --   include = { "typescript", "typescriptreact" },
  -- })
  -- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
  -- luasnip.filetype_extend("typescript", { "javascript" })
  -- luasnip.filetype_extend("typescriptreact", { "javascript", "typescript" })
  ---
  vim.keymap.set({ "i", "s" }, "<C-L>", function()
    luasnip.jump(1)
  end, { silent = true })
  vim.keymap.set({ "i", "s" }, "<C-J>", function()
    luasnip.jump(-1)
  end, { silent = true })

  vim.keymap.set({ "i", "s" }, "<C-E>", function()
    if luasnip.choice_active() then
      luasnip.change_choice(1)
    end
  end, { silent = true })
  ---

  cmp.setup({
    enabled = function()
      return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
    end,
    sorting = {
      priority_weight = 1.0,
      comparators = {
        compare.offset,
        compare.exact,
        compare.score,
        compare.recently_used,
        compare.locality,
        compare.kind,
        compare.sort_text,
        compare.length,
      },
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    sources = {
      { name = "nvim_lsp", priority = 1100 },
      { name = "luasnip", priority = 1000 },
      { name = "buffer", priority = 500 },
      { name = "path", priority = 250 },
      { name = "vim-dadbod-completion" },
      { name = "dotenv" },
      { name = "crates" },
      { name = "neorg" },
      -- { name = "ts_repl" },
    },
    view = {
      entries = {
        name = "custom",
        selection_order = "top_down",
      },
      docs = {
        auto_open = true,
      },
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-d>"] = cmp.mapping.scroll_docs(-4), -- Up
      ["<C-u>"] = cmp.mapping.scroll_docs(4), -- Down
      ["<tab>"] = cmp.mapping.select_next_item(),
      ["<C-a>"] = cmp.mapping.select_prev_item(),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }),
    }),
  })
  -- cmp.setup.filetype({ "norg" }, { sources = { name = "neorg" } })
  cmp.setup.filetype({ "dap-repl", "dapui_watches" }, {
    sources = {
      { name = "dap" },
      { name = "nvim_lsp" }, -- Enable LSP completion
      { name = "buffer" }, -- Optionally, add buffer completion
    },
  })
  -- require("cmp").register_source("curl", require("curl-cmp"))
  require("cmp").setup.filetype({ "curl" }, {
    sources = {
      { name = "curl" },
      { name = "dotenv" },
    },
  })
  vim.lsp.handlers["textDocument/diagnostic"] = vim.lsp.with(vim.lsp.diagnostic.on_diagnostic, {
    underline = true,
    virtual_text = {
      spacing = 4,
    },
    signs = function(namespace, bufnr)
      return vim.b[bufnr].show_signs == true
    end,
    update_in_insert = true,
  })
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline({ -- ["<C-o>"] = cmp.mapping.scroll_docs(-4), -- Up
      -- ["<C-p>"] = cmp.mapping.scroll_docs(4), -- Down
      -- ["<tab>"] = cmp.mapping.select_next_item(),
      -- ["<C-a>"] = cmp.mapping.select_prev_item(),
      -- ["<C-Space>"] = cmp.mapping.complete(),
      -- ["<CR>"] = cmp.mapping.confirm({
      --   behavior = cmp.ConfirmBehavior.Replace,
      --   select = true,
      -- }),
    }),
    sources = cmp.config.sources({
      { name = "path", priority = 1 },
      -- { name = "dotenv", priority = 3 },
      { name = "buffer", priority = 2 },
    }, {
      {
        name = "cmdline",
        option = {
          ignore_cmds = { "Man", "!" },
        },
      },
    }),
  })
  cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline({ -- ["<C-o>"] = cmp.mapping.scroll_docs(-4), -- Up
      -- ["<C-p>"] = cmp.mapping.scroll_docs(4), -- Down
      ["<tab>"] = cmp.mapping.select_next_item(),
      ["<C-a>"] = cmp.mapping.select_prev_item(),
      -- ["<C-Space>"] = cmp.mapping.complete(),
      -- ["<CR>"] = cmp.mapping.confirm({
      --   behavior = cmp.ConfirmBehavior.Replace,
      --   select = true,
      -- }),
    }),
    sources = {
      { name = "buffer" },
      -- { name = "dotenv" },
    },
  })
end

return Plug
