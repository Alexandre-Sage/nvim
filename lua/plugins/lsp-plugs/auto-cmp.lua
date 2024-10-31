local Plug = { "hrsh7th/nvim-cmp" }

Plug.dependencies = {
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "saadparwaiz1/cmp_luasnip" },
  { "L3MON4D3/LuaSnip", build = "make install_jsregexp" }, -- Ensure LuaSnip build step is here
  {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  { "rcarriga/cmp-dap" },
}

Plug.event = "InsertEnter"

function Plug.config()
  local cmp = require("cmp")
  local snip = require("luasnip")
  local compare = cmp.config.compare
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
        snip.lsp_expand(args.body)
      end,
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "buffer" },
      { name = "luasnip" },
      { name = "path" },
      { name = "vim-dadbod-completion" },
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
      -- ["<C-o>"] = cmp.mapping.scroll_docs(-4), -- Up
      -- ["<C-p>"] = cmp.mapping.scroll_docs(4), -- Down
      ["<tab>"] = cmp.mapping.select_next_item(),
      ["<C-a>"] = cmp.mapping.select_prev_item(),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
    }),
  })
  cmp.setup.filetype({ "dap-repl", "dapui_watches" }, {
    sources = {
      { name = "dap" },
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
    update_in_insert = false,
  })
end

return Plug
