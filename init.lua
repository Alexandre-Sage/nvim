local helpers = require("helpers")
vim.g.mapleader = ","

-- local shada_dir = os.getenv("HOME") .. "/.local/share/nvim/shada"
-- local global_shada = os.getenv("HOME") .. "/.local/share/nvim/shada/main.shada"
--
-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     if not vim.fn.isdirectory(shada_dir) then
--       vim.fn.mkdir(shada_dir, "p")
--     end
--     local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
--     local project_name = vim.fn.fnamemodify(git_root, ":t")
--
--     if git_root ~= "" then
--       local project_shada = shada_dir .. project_name .. ".shada"
--       if vim.fn.filereadable(project_shada) == 1 then
--         vim.o.shadafile = project_shada
--       else
--         vim.o.shadafile = global_shada
--       end
--     else
--       vim.o.shadafile = global_shada
--     end
--   end,
-- })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.cmd("wincmd J")
    vim.api.nvim_buf_set_keymap(0, "n", "ca", "", {
      noremap = true,
      silent = true,
      callback = function()
        -- Get the current line item from quickfix
        local qf_item = vim.fn.getqflist()[vim.fn.line(".")]

        -- Jump to the file and position
        vim.cmd(string.format("edit +%d %s", qf_item.lnum, qf_item.filename))

        -- Trigger code action at this position
        vim.lsp.buf.code_action()
      end,
      desc = "Trigger code action for quickfix item",
    })
  end,
})

vim.api.nvim_create_augroup("TypeScriptMake", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "TypeScriptMake",
  pattern = { "typescript", "typescriptreact" },
  callback = function()
    vim.cmd("compiler tsc")
  end,
})

local load = function(mod)
  package.loaded[mod] = nil
  require(mod)
end
helpers.parse_key_map(require("user.keymaps.neovim"))
-- vimgrep
-- cfdo %s//gj
require("user.plugins")
require("user.commands")
require("user.customcommands")
require("user.config")
require("plugins.telescope.plugins.git-pickers.__git_dff_picker")
require("plugins.telescope.plugins.lsp-pcikers.__rename-pop-up")
require("plugins.telescope.plugins.utils.__diff-view-file-fist")
require("plugins.telescope.plugins.utils.__search-read")
