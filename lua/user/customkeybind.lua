local map_key = require("helpers").map_key
local normal_cmd = require("helpers").normal_cmd

map_key({ "n" }, "<leader>s", normal_cmd("w"), { desc = "save", noremap = true })
map_key({ "n" }, "<leader>z", normal_cmd("u"), { desc = "undo", noremap = true, silent = true })
-- map("n", "<c-a>", get_normal_cmd("wa"), { desc = "Ctrl+a to save all file", noremap = true })
map_key("n", "<c-t>", normal_cmd("tabnext"), { desc = "Ctr+Tab go to next tab" })
map_key("n", "<c-l>", normal_cmd("BufferNext"), { desc = "Ctrl + m for bar bar next tab" })
map_key("n", "<c-h>", normal_cmd("BufferPrevious"), { desc = "Ctrl + l for bar bar prev tab" })
map_key("n", "<c-q>", normal_cmd("BufferClose"), { desc = "Ctrl + Tab for bar bar close tab" })
map_key("n", "<leader>g", normal_cmd("Neogit"), { desc = " open neo git" })
map_key("v", "<leader>d", '"_d', { desc = "Delete to black hole" })
map_key({ "v" }, "<leader>t", normal_cmd("ToggleTermSendVisualSelection"))
map_key({ "v" }, "<leader>T", normal_cmd("ToggleTermSendVisualLine"))
map_key("n", "Rr", normal_cmd("Rr"), { desc = "Rr to rester search", noremap = true })
map_key({ "n", "v" }, "Br", normal_cmd("Break"), { desc = "Br to set break point", noremap = true })

map_key({ "i" }, "<c-h>", "<Left>", {})
map_key({ "i" }, "<c-j>", "<Down>", {})
map_key({ "i" }, "<c-k>", "<Up>", {})
map_key({ "i" }, "<c-l>", "<Right>", {})

map_key({ "v", "n" }, "<leader>rn", normal_cmd("set relativenumber"))
map_key({ "v", "n" }, "<leader>an", normal_cmd("set norelativenumber"))
map_key({ "n" }, "<leader>cB", normal_cmd("BufferCloseAllButCurrent"), { desc = "Close all buffer but current" })
vim.api.nvim_set_keymap("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]], {})
vim.api.nvim_set_keymap("n", "<leader>ql", [[<cmd>lua require("persistence").load({ last = true })<cr>]], {})
vim.api.nvim_set_keymap("n", "<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]], {})
