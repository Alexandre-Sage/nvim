local function organize_imports()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = ""
	}
	vim.lsp.buf.execute_command(params)
end

local function add_missing_imports()
	local params = {
		command = "_typescript.addMissingImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = ""
	}
	vim.lsp.buf.execute_command(params)
end


local function removed_ununsed_imports()
	local params = {
		command = "_typescript.removeUnusedImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = ""
	}
	vim.lsp.buf.execute_command(params)
end

vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("TS_add_missing_imports", { clear = true }),
	desc = "TS_add_missing_imports",
	pattern = { "*.ts" },
	callback = removed_ununsed_imports
})


return function(lspconfig, lsp_capabilities)
	lspconfig.tsserver.setup({
		capabilities = lsp_capabilities,
		commands = {
			OrganizeImports = {
				organize_imports,
				description = "Organize Imports"
			},
			AddImport = {
				add_missing_imports
			},
			RemoveUnusedImports = {
				removed_ununsed_imports
			}
		},
		init_options = {
			preferences = {
				importModuleSpecifierPreference = "project-relative",
				quotePreference = "double",
				typescript = {
					format = {
						semicolons = "insert"
					},
				},
				implicitProjectConfiguration = {
					strictFunctionTypes = true
				},
			}
		},
		settings = {
			completions = {
				completeFunctionCalls = true
			},
		}
	})
end
