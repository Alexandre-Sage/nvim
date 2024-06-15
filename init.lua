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
require("plugins.telescope.plugins.__git_dff_picker")
require("nice-blue.dist.nice-blue")
