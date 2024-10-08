local map_key = require("helpers").map_key
local normal_cmd = require("helpers").normal_cmd

function _(mods, key, command, opts)
  return { mods = mods, key = key, commands = command, opts = opts }
end

map_key("n", "<c-t>", normal_cmd("tabnext"), { desc = "go to next tab" })
map_key("n", "<c-q>", normal_cmd("BufferClose"), { desc = "bar bar close tab" })
map_key("n", "<leader>ng", normal_cmd("Neogit"), { desc = " open neo git" })
map_key("v", "<leader>d", '"_d', { desc = "Delete to black hole" })
map_key({ "v" }, "<leader>t", normal_cmd("ToggleTermSendVisualSelection"))
map_key({ "v" }, "<leader>T", normal_cmd("ToggleTermSendVisualLine"))
map_key("n", "Rr", normal_cmd("Rr"), { desc = "reset search", noremap = true })
map_key({ "n", "v" }, "Br", normal_cmd("Break"), { desc = "Br to set break point", noremap = true })
map_key({ "n" }, "<leader>dvo", normal_cmd("DiffviewOpen"), { desc = "Open diff view" })
map_key({ "n" }, "<leader>dvc", normal_cmd("DiffviewClose"), { desc = "Close diff view" })
map_key({ "n", "v" }, "<leader>cp", '"+y', { desc = "Br to set break point", noremap = true })

map_key({ "i" }, "<c-h>", "<Left>", {})
map_key({ "i" }, "<c-j>", "<Down>", {})
map_key({ "i" }, "<c-k>", "<Up>", {})
map_key({ "i" }, "<c-l>", "<Right>", {})
map_key({ "n", "v" }, "<Up>", "<Nop>", {})
map_key({ "n", "v" }, "<Down>", "<Nop>", {})
map_key({ "n", "v" }, "<Left>", "<Nop>", {})
map_key({ "n", "v" }, "<Right>", "<Nop>", {})
map_key({ "v", "n" }, "<leader>rn", normal_cmd("set relativenumber"))
map_key({ "v", "n" }, "<leader>An", normal_cmd("set norelativenumber"))
map_key({ "n" }, "<leader>cB", normal_cmd("BufferCloseAllButCurrent"), { desc = "Close all buffer but current" })
map_key({ "n" }, "<space>o", "a<CR><ESC>", { desc = "line break after" })
map_key({ "n" }, "<space>O", "i<CR><ESC>", { desc = "line break before" })
map_key({ "n" }, "<leader>m", "'", {})
vim.keymap.set("n", "<leader>dN", [[<cmd>lua vim.diagnostic.goto_next()<cr><cmd>lua vim.lsp.buf.code_action()<cr>]])
vim.api.nvim_set_keymap("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]], {})
vim.api.nvim_set_keymap("n", "<leader>ql", [[<cmd>lua require("persistence").load({ last = true })<cr>]], {})
vim.api.nvim_set_keymap("n", "<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]], {})

local keymaps = {
  { mods = { "n" }, map = "<c-l>", command = normal_cmd("BufferNext"), opts = { desc = "Bar bar next tab" } },
  { mods = { "n" }, map = "<c-h>", command = normal_cmd("BufferPrevious"), opts = { desc = "Bar bar prev tab" } },
}
for key, value in pairs(keymaps) do
  vim.keymap.set(value.mods, value.map, value.command, value.opts)
end
