return {
  {
    name = "rust-lldb",
    config = {
      type = "executable",
      command = require("mason-registry").get_package("codelldb"):get_install_path() .. "/codelldb", -- Adjust this path
      name = "lldb",
    },
  },
}
