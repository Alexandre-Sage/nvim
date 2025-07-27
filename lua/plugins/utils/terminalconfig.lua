local Plug = { "akinsho/toggleterm.nvim" }

Plug.version = "*"

Plug.opts = {
  direction = "float",
}

Plug.config = true
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  -- vim.keymap.set("t", "<C-H>", [[<Cmd>wincmd h<CR>]], opts)
  -- vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  -- vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  -- vim.keymap.set("t", "<C-L>", [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
return Plug
