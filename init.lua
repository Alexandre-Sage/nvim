vim.g.mapleader = ","
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
require("plugins.telescope.plugins.git-pickers.__git_dff_picker")
require("plugins.telescope.plugins.lsp-pcikers.code-actions-picker")
