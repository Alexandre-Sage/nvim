local Plug = { "stevearc/aerial.nvim" }

Plug.dependencies = {
  "nvim-treesitter/nvim-treesitter",
  "nvim-tree/nvim-web-devicons",
}

Plug.opts = {
  backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
  layout = { min_width = 15 },
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
}

function Plug.init()
  vim.keymap.set("n", "<leader>ta", "<cmd>AerialToggle!<CR>")
  vim.keymap.set("n", "<leader>a", "<cmd>AerialNavToggle<CR>")
  vim.keymap.set("n", "<leader>A", "<cmd>AerialOpen<CR>")
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "BufAdd" }, {
    pattern = {
      "*.lua",
      "*.ts",
      "*.tsx",
      "*.jsx",
      "*.rs",
      "*.js",
    },
    callback = function()
      if vim.bo.filetype == ".json" then
        return
      end
      --vim.cmd([[
      --AerialOpen!
      -- ]])
    end,
    -- command = "AerialOpen!",
  })
end

return Plug
