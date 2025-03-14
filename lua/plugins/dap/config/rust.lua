return {
  {
    name = "rust",
    config = {
      {
        name = "Launch",
        type = "rust-lldb",
        request = "launch",
        program = function()
          -- print("Building the project with cargo...")
          local bufnr = vim.api.nvim_create_buf(false, true)
          local width = math.floor(vim.o.columns * 0.8)
          local height = math.floor(vim.o.lines * 0.6)
          local row = math.floor((vim.o.lines - height) / 2)
          local col = math.floor((vim.o.columns - width) / 2)

          local win_opts = {
            relative = "editor",
            width = width,
            height = height,
            row = row,
            col = col,
            style = "minimal",
            border = "rounded",
            title = "Cargo Build Output",
            title_pos = "center",
          }

          local win_id = vim.api.nvim_open_win(bufnr, true, win_opts)
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "Building the project with cargo..." })

          -- Execute cargo build and capture output
          local build_output = vim.fn.systemlist("cargo build 2>&1")

          -- Display the output in the floating window
          vim.api.nvim_buf_set_lines(bufnr, 1, -1, false, build_output)

          -- Check build result
          local build_result = vim.v.shell_error
          if build_result ~= 0 then
            vim.api.nvim_buf_set_lines(bufnr, #build_output + 1, -1, false, { "", "Cargo build failed!" })

            -- Auto-close the window after a delay (even for failure)
            vim.defer_fn(function()
              if vim.api.nvim_win_is_valid(win_id) then
                vim.api.nvim_win_close(win_id, true)
              end
            end, 5000) -- Close after 5 seconds for failures (longer to read errors)

            return nil
          end

          local metadata_json = vim.fn.system("cargo metadata --format-version 1 --no-deps")
          local metadata = vim.fn.json_decode(metadata_json)
          local target_name = metadata.packages[1].targets[1].name
          local target_dir = metadata.target_directory
          return target_dir .. "/debug/" .. target_name
        end,
        cwd = "${workspaceFolder}",
        -- stopOnEntry = false,
        terminal = "integrated",
        args = {},
        -- runInTerminal = false,
        console = "integratedTerminal",
        env = function()
          -- Load .env file into a table
          local env = {}
          local f = io.open(".env", "r")
          if f then
            for line in f:lines() do
              -- Skip comments and empty lines
              if not line:match("^%s*#") and line:match("%S") then
                local key, value = line:match("^%s*(%S+)%s*=%s*(.+)%s*$")
                if key and value then
                  -- Remove surrounding quotes if present (matching Rust's dotenv behavior)
                  value = value:gsub('^"(.*)"$', "%1")
                  value = value:gsub("^'(.*)'$", "%1")
                  env[key] = value
                end
              end
            end
            f:close()
          end
          return env
        end,
      },
    },
  },
}
