local Plug = { "neovim/nvim-lspconfig" }

local PlugHaskell = {
  "mrcjkb/haskell-tools.nvim",
}
PlugHaskell.enabled = false
PlugHaskell.lazy = false -- This plugin is already lazy
PlugHaskell.version = "^4" -- Recommended
PlugHaskell.opts = {
  setup = {
    purescriptls = function(_, opts)
      opts.root_dir = function(path)
        local util = require("lspconfig.util")
        if path:match("/.spago/") then
          return nil
        end
        return util.root_pattern("bower.json", "psc-package.json", "spago.dhall", "flake.nix", "shell.nix")(path)
      end
    end,
  },
}

local on_attach = function(ev)
  -- Enable completion triggered by <c-x><c-o>
  vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
  -- Buffer local mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local opts = { buffer = ev.buf }

  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
  -- vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<space>f", function()
    vim.lsp.buf.format({ async = true })
  end, opts)
  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
end

Plug.dependencies = {
  { "hrsh7th/cmp-nvim-lsp" },
  { "williamboman/mason-lspconfig.nvim" },
  { "simrat39/rust-tools.nvim" },
  { "purescript-contrib/purescript-vim" },
  { "folke/neodev.nvim", opts = {} },
  { "neovimhaskell/haskell-vim" },
  PlugHaskell,
}

Plug.cmd = { "LspInfo", "LspInstall", "LspUnInstall" }

Plug.event = { "BufReadPre", "BufNewFile" }
function Plug.on_attach() end

function Plug.config()
  vim.keymap.set("n", "D", vim.diagnostic.open_float)
  vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev)
  vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next)
  vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)
  require("neodev").setup()
  local group = vim.api.nvim_create_augroup("lsp_cmds", { clear = true })
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
      "tsserver",
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
      ["tsserver"] = function()
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
