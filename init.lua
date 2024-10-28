vim.g.mapleader = ","

local shada_dir = os.getenv("HOME") .. "/.local/share/nvim/shada"
local global_shada = os.getenv("HOME") .. "/.local/share/nvim/shada/main.shada"

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if not vim.fn.isdirectory(shada_dir) then
      vim.fn.mkdir(shada_dir, "p")
    end
    local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    local project_name = vim.fn.fnamemodify(git_root, ":t")

    if git_root ~= "" then
      local project_shada = shada_dir .. project_name .. ".shada"
      if vim.fn.filereadable(project_shada) == 1 then
        vim.o.shadafile = project_shada
      else
        vim.o.shadafile = global_shada
      end
    else
      vim.o.shadafile = global_shada
    end
  end,
})

local load = function(mod)
  package.loaded[mod] = nil
  require(mod)
end

-- vimgrep
-- cfdo %s//gj
require("user.plugins")
require("user.commands")
require("user.customkeybind")
require("user.customcommands")
require("user.config")
require("plugins.telescope.plugins.git-pickers.__git_dff_picker")
require("plugins.telescope.plugins.lsp-pcikers.__rename-pop-up")
require("plugins.telescope.plugins.utils.__diff-view-file-fist")
require("plugins.telescope.plugins.utils.__search-read")
