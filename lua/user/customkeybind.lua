local map_key = require("helpers").map_key
local normal_cmd = require("helpers").normal_cmd

map_key({ "n", "i" }, "<c-s>", normal_cmd("w"), { desc = "Ctrl+s to save", noremap = true })
map_key({ "n", "i" }, "<c-z>", normal_cmd("u"), { desc = "Ctrl+z to undo", noremap = true, silent = true })
-- map("n", "<c-a>", get_normal_cmd("wa"), { desc = "Ctrl+a to save all file", noremap = true })
map_key("n", "<c-t>", normal_cmd("tabnext"), { desc = "Ctr+Tab go to next tab" })
map_key("n", "<c-m>", normal_cmd("BufferNext"), { desc = "Ctrl + m for bar bar next tab" })
map_key("n", "<c-l>", normal_cmd("BufferPrevious"), { desc = "Ctrl + l for bar bar prev tab" })
map_key("n", "<c-q>", normal_cmd("BufferClose"), { desc = "Ctrl + Tab for bar bar close tab" })
map_key("n", "<leader>g", normal_cmd("Neogit"), { desc = "G in normal mode to view open neo git" })
map_key("v", "<leader>d", '"_d', { desc = "Delete to black hole" })
map_key({ "v" }, "<leader>t", normal_cmd("ToggleTermSendVisualSelection"))
map_key({ "v" }, "<leader>T", normal_cmd("ToggleTermSendVisualLine"))
map_key("n", "Rr", normal_cmd("Rr"), { desc = "Rr to rester search", noremap = true })
map_key({ "n", "v" }, "Br", normal_cmd("Break"), { desc = "Br to set break point", noremap = true })
--azerty mapping
map_key({ "v" }, "aù", "a[", { desc = "Replace a[ in visual mode (azerty mapping)" })
map_key({ "v" }, "a*", "a]", { desc = "Replace a] in visual mode (azerty mapping)" })
map_key({ "v" }, "iù", "i[", { desc = "Replace i[ in visual mode (azerty mapping)" })
map_key({ "v" }, "i*", "i]", { desc = "Replace i] in visual mode (azerty mapping)" })
--vim.api.nvim_set_keymap({ "v", "n", "i" }, "(", "<Nop>[", {})

map_key({ "i" }, "<c-h>", "<Left>", {})
map_key({ "i" }, "<c-j>", "<Down>", {})
map_key({ "i" }, "<c-k>", "<Up>", {})
map_key({ "i" }, "<c-l>", "<Right>", {})

map_key({ "v", "n" }, "<C-c>", require("actions-preview").code_actions)
vim.api.nvim_set_keymap("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]], {})
vim.api.nvim_set_keymap("n", "<leader>ql", [[<cmd>lua require("persistence").load({ last = true })<cr>]], {})
vim.api.nvim_set_keymap("n", "<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]], {})
