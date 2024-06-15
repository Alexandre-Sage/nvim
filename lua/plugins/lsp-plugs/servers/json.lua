-- local capabilities = vim.lsp.protocol.make_client_capabilities()
return function(lspconfig, capabilities)
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	lspconfig.jsonls.setup {
		capabilities = capabilities,
		filetypes = { "json", "jsonc" },
		settings = {
			json = {
				schemas = require('schemastore').json.schemas(),
				validate = { enable = true },
				--  Schemas https://www.schemastore.org
			}
		}
	}
end
