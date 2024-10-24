local Plug = { "neovim/nvim-lspconfig" }
local helpers = require("helpers")
local keymaps = require("plugins.lsp-plugs.commons.keymaps")
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
}

Plug.cmd = { "LspInfo", "LspInstall", "LspUnInstall" }

Plug.event = { "BufReadPre", "BufNewFile" }
function Plug.on_attach() end

function Plug.config()
  helpers.parse_key_map(keymaps.lspconfig)
  require("neodev").setup()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = on_attach,
  })
  local lspconfig = require("lspconfig")
  local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
  lspconfig.hls.setup({
    filetypes = { "Haskell", "haskell", "lhaskell", "cabal", "hs" },
  })
  require("mason-lspconfig").setup({
    ensure_installed = {
      "eslint",
      "ts_ls",
      "html",
      "cssls",
      "lua_ls",
      "dockerls",
      "rust_analyzer",
      "yamlls",
      "jsonls",
      "sqlls",
    },
    handlers = {
      -- See :help mason-lspconfig-dynamic-server-setup
      function(server)
        -- See :help lspconfig-setup
        lspconfig[server].setup({
          capabilities = lsp_capabilities,
        })
      end,
      ["ts_ls"] = function()
        require("plugins.lsp-plugs.servers.typescript")(lspconfig, lsp_capabilities)
      end,
      ["rust_analyzer"] = function()
        require("plugins.lsp-plugs.servers.rust")(lspconfig, lsp_capabilities)
      end,
      ["lua_ls"] = function()
        require("plugins.lsp-plugs.servers.luals")(lspconfig)
      end,
      ["jsonls"] = function()
        require("plugins.lsp-plugs.servers.json")(lspconfig, lsp_capabilities)
      end,
      ["yamlls"] = function()
        require("plugins.lsp-plugs.servers.yaml")(lspconfig, lsp_capabilities)
      end,
      ["sqlls"] = function()
        require("plugins.lsp-plugs.servers.sql")(lspconfig)
      end,
      -- ["hls"] = function()
      --   require("plugins.lsp-plugs.servers.haskell")(lspconfig, lsp_capabilities)
      -- end,
    },
  })
end

return Plug
