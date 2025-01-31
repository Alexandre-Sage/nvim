local Plug = { "neovim/nvim-lspconfig" }
local helpers = require("helpers")
local keymaps = require("user.keymaps.lsp-keymaps")
local servers_configs = require("user.lsp.servers.servers")
local default = require("user.lsp.default-installed")
local on_attach = function(ev)
  vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
  helpers.parse_key_map(keymaps.attach(ev.buf))
end

Plug.dependencies = {
  { "hrsh7th/cmp-nvim-lsp" },
  { "williamboman/mason-lspconfig.nvim" },
  { "simrat39/rust-tools.nvim" },
  { "folke/neodev.nvim", opts = {} },
  { "neovimhaskell/haskell-vim" },
  { "jay-babu/mason-nvim-dap.nvim" },
}

Plug.cmd = { "LspInfo", "LspInstall", "LspUnInstall" }

Plug.event = { "BufReadPre", "BufNewFile" }
function Plug.on_attach() end

function Plug.config()
  helpers.parse_key_map(keymaps.lspconfig)
  -- require("neodev").setup()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = on_attach,
  })
  local lspconfig = require("lspconfig")
  -- lspconfig.hls.setup({
  --   filetypes = { "Haskell", "haskell", "lhaskell", "cabal", "hs" },
  -- })
  require("mason-nvim-dap").setup({
    ensure_installed = default.debbuger,
    automatic_installation = true,
    handlers = nil,
  })
  require("mason-lspconfig").setup({
    ensure_installed = default.lsp,
    automatic_installation = true,
    handlers = (function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lsp_servers = {
        -- ["rust-analyzer"] = require("rust-tools").setup({
        --   settings = {
        --     ["rust-analyzer"] = {
        --       cargo = {
        --         allFeatures = true,
        --       },
        --     },
        --   },
        --   capabilities,
        -- }),
      }
      for _, server in pairs(servers_configs) do
        server.opts.capabilities = capabilities
        lsp_servers[server.name] = require("lspconfig")[server.name].setup(server.opts)
      end
      return lsp_servers
    end)(),
  })
end
return Plug
