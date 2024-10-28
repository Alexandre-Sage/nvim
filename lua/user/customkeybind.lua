local normal_cmd = require("helpers").normal_cmd
local parse_key_map = require("helpers").parse_key_map

local keymaps = {
  { { "n" }, "<C-j>", "<C-w>j", {} },
  { { "n" }, "<C-k>", "<C-w>k", {} },
  { { "n" }, "<C-l>", "<C-w>l", {} },
  { { "n" }, "<C-h>", "<C-w>h", {} },
  { { "n", "v" }, "<Up>", "<Nop>", {} },
  { { "n", "v" }, "<Down>", "<Nop>", {} },
  { { "n", "v" }, "<Left>", "<Nop>", {} },
  { { "n", "v" }, "<Right>", "<Nop>", {} },
  { { "i" }, "<c-h>", "<Left>", {} },
  { { "i" }, "<c-j>", "<Down>", {} },
  { { "i" }, "<c-k>", "<Up>", {} },
  { { "i" }, "<c-l>", "<Right>", {} },
  { "n", "<leader>ng", normal_cmd("Neogit"), { desc = " open neo git" } },
  { "v", "<leader>d", '"_d', { desc = "Delete to black hole" } },
  { { "n", "v" }, "<leader>cp", '"+y', { desc = "Yank to clipboard", noremap = true } },
  { { "n", "v" }, "<leader>mv", '"+d', { desc = "Delete to clipboard", noremap = true } },
  { { "v", "n" }, "<leader>rn", normal_cmd("set relativenumber") },
  { { "v", "n" }, "<leader>An", normal_cmd("set norelativenumber") },
  { { "n" }, "<space>o", "a<CR><ESC>", { desc = "line break after" } },
  { { "n" }, "<space>O", "i<CR><ESC>", { desc = "line break before" } },
  { { "n" }, "<leader>m", "'", {} },
  { "n", "<leader>dN", [[<cmd>lua vim.diagnostic.goto_next()<cr><cmd>lua vim.lsp.buf.code_action()<cr>]] },
  { "n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]], {} },
  { "n", "<leader>ql", [[<cmd>lua require("persistence").load({ last = true })<cr>]], {} },
  { "n", "<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]], {} },
  { "n", "<leader>cu", normal_cmd("CurlOpen"), { desc = "Curl open" } },
  { { "v" }, "<leader>t", normal_cmd("ToggleTermSendVisualSelection") },
  { { "v" }, "<leader>T", normal_cmd("ToggleTermSendVisualLine") },
  { { "n" }, "<leader>dvo", normal_cmd("DiffviewOpen"), { desc = "Open diff view" } },
  { { "n" }, "<leader>dvc", normal_cmd("DiffviewClose"), { desc = "Close diff view" } },
}

parse_key_map(keymaps)
