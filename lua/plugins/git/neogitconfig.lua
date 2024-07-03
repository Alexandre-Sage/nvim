local Plug = { "NeogitOrg/neogit" }
Plug.dependencies = {
  { "nvim-lua/plenary.nvim" }, -- required
  { "sindrets/diffview.nvim" }, -- optional - Diff integration
  { "nvim-telescope/telescope.nvim" },
  { "f-person/git-blame.nvim" }, -- optional
}

Plug.opts = {
  integration = {
    diffview = true,
    telescope = true,
  },
  commit_editor = {
    kind = "vsplit",
  },
}

--  function Plug.config()
--  	require("neo")
--  end
return Plug
