-- autodetect root workspace
-- on_attach = function(client, bufnr)
--     -- Automatically change the current directory to the project root
--     local project_root = util.root_pattern('package.json', 'tsconfig.json', '.git')(vim.fn.expand('%:p'))
--     if project_root then
--       vim.cmd('cd ' .. project_root)
--     end
--   end,
--   root_dir = util.root_pattern('package.json', 'tsconfig.json', '.git'),
local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = "",
  }
  vim.lsp.buf.execute_command(params)
end

local function add_missing_imports()
  local params = {
    command = "_typescript.addMissingImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = "",
  }
  vim.lsp.buf.execute_command(params)
end

local function removed_ununsed_imports()
  local params = {
    command = "_typescript.removeUnusedImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = "",
  }
  vim.lsp.buf.execute_command(params)
end

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("TS_add_missing_imports", { clear = true }),
  desc = "TS_add_missing_imports",
  pattern = { "*.ts" },
  callback = removed_ununsed_imports,
})

return {
  name = "ts_ls",
  opts = {
    -- on_attach = function(client, bufnr)
    --   -- Optional: Force a full scan on attach
    --   vim.fn.jobstart({ "tsc", "--noEmit", "--watch" }, {
    --     on_stderr = function(_, data)
    --       vim.fn.setqflist({}, "r", { lines = data })
    --     end,
    --   })
    --   vim.lsp.buf_request(0, "tsserver/reloadProjects", {}, function(err, result)
    --     if err then
    --       print("Reload error: " .. vim.inspect(err))
    --     end
    --   end)
    -- end,
    -- root_dir = { "tsconfig.json", "package.json", ".git" },
    commands = {
      OrganizeImports = {
        organize_imports,
        description = "Organize Imports",
      },
      AddImport = {
        add_missing_imports,
      },
      RemoveUnusedImports = {
        removed_ununsed_imports,
      },
    },
    diagnostics = {
      -- Enable all diagnostics (though ts_ls might ignore this)
      ignoredCodes = {}, -- Customize if needed
    },
    flags = {
      debounce_text_changes = 150, -- Adjust if needed
    },
    init_options = {
      lint = true,
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
          },
          format = {
            semicolons = "insert",
          },
        },
        completions = {
          completeFunctionCalls = true,
        },
      },
      preferences = {
        importModuleSpecifierPreference = "project-relative",
        quotePreference = "double",
        includeInlayParameterNameHints = "all", -- Optional, for better UX
        implicitProjectConfiguration = {
          strictFunctionTypes = true,
        },
      },
    },
  },
}
