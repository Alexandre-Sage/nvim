local create_user_command = require("helpers").create_user_command
return function(api)
  create_user_command("FindInFolder", function(opts)
    api.find_in_project({
      search_dirs = { opts.args },
      no_ignore = true,
      hidden = true,
      file_ignore_patterns = { "node_modules" },
    })
  end, "?")
end
