return function(telescope)
  return {
    find_in_files = function(opts)
      return telescope.find_files({ no_ignore = true, hidden = true, file_ignore_patterns = { "node_modules" } })
    end,
    find_in_project = function(opts)
      return telescope.live_grep()
    end,
    find_in_current_file = function(opts)
      return telescope.current_buffer_fuzzy_find({ results_ts_highlight = true })
    end,
    opened_buffers = function()
      return telescope.buffers()
    end,
    lsp_references = function()
      return telescope.lsp_references()
    end,
    current_buffer_diagnostic = function()
      return telescope.diagnostics({ bufnr = 0 })
    end,
    lsp_definitions = function()
      return telescope.lsp_definitions()
    end,
  }
end
