return {
  {
    name = "rust",
    config = {
      {
        name = "Launch",
        type = "rust-lldb",
        request = "launch",
        program = function()
          print("Building the project with cargo...")
          local build_result = os.execute("cargo build")

          if build_result ~= 0 then
            print("Cargo build failed!")
            return nil
          end
          -- Detect the target binary
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
