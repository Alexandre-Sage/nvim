local Plug = { "hrsh7th/nvim-cmp" }

Plug.dependencies = {
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "saadparwaiz1/cmp_luasnip" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "L3MON4D3/LuaSnip" },
  { "rafamadriz/friendly-snippets" },
}

Plug.event = "InsertEnter"

function Plug.config()
  local cmp = require("cmp")
  local snip = require("luasnip")
  local compare = cmp.config.compare
  cmp.setup({
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
        -- compare.scopes,
        -- compare.locality,
        -- compare.exact,
        -- compare.score,
        -- compare.kind,
        -- compare.recently_used,
        -- compare.offset,
        -- compare.sort_text,
        -- compare.length,
        -- compare.order,
      },
    },
    window = {
      completion = {
        border = "rounded",
        scrollbar = "||",
      },
      documentation = {
        border = "rounded",
        scrollbar = "||",
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
      ["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Up
      ["<C-d>"] = cmp.mapping.scroll_docs(4), -- Down
      ["<tab>"] = cmp.mapping.select_next_item(),
      ["<C-a>"] = cmp.mapping.select_prev_item(),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
    }),
  })
  -- vim.api.nvim_create_autocmd("BufWritePre", {
  --   pattern = "*",
  --   callback = function(args)
  --     require("conform").format({ bufnr = args.buf })
  --   end,
  -- })
  -- vim.api.nvim_create_autocmd("BufWritePre", {
  -- 	callback = function()
  -- 		vim.lsp.buf.format({
  -- 			async = false,
  -- 		})
  -- 	end,
  -- })

  vim.lsp.handlers["workspace/didChangeConfiguration"] = vim.lsp.with({
    typescript = {
      format = {
        semicolons = "insert",
      },
    },
  })
  vim.lsp.handlers["textDocument/diagnostic"] = vim.lsp.with(vim.lsp.diagnostic.on_diagnostic, {
    -- Enable underline, use default values
    underline = true,
    -- Enable virtual text, override spacing to 4
    virtual_text = {
      spacing = 4,
    },
    -- Use a function to dynamically turn signs off
    -- and on, using buffer local variables
    signs = function(namespace, bufnr)
      return vim.b[bufnr].show_signs == true
    end,
    -- Disable a feature
    update_in_insert = false,
  })
end

return Plug
