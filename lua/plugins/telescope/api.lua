return function(telescope, themes)
	return {
		find_in_files = function(opts)
			return telescope.find_files({
				no_ignore = true,
				hidden = true,
				file_ignore_patterns = { ".git", "node_modules", "dist", "build", "target" },
			})
		end,
		find_in_project = function(opts)
			return telescope.live_grep(opts)
		end,
		find_in_current_file = function(opts)
			return telescope.current_buffer_fuzzy_find({ results_ts_highlight = true })
		end,
		opened_buffers = function()
			return telescope.buffers({ sort_mru = true, only_cwd = true })
		end,
		lsp_references = function()
			return telescope.lsp_references()
		end,
		current_buffer_diagnostic = function()
			return telescope.diagnostics({ bufnr = 0 })
		end,
		project_buffer_diagnostic = function()
			return telescope.diagnostics({ severity = vim.diagnostic.severity.ERROR })
		end,
		lsp_definitions = function()
			return telescope.lsp_definitions()
		end,
		marks = function()
			return telescope.marks()
		end,
		registers = function()
			return telescope.registers(themes.get_ivy({}))
		end,
	}
end
