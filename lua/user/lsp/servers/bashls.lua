return {
  name = "bashls",
  opts = {
    filetypes = { ".zsh", ".curl", ".sh", "curl" },
    cmd_env = vim.fn.systemlist('bash -c "source ~/.zshrc && env"'), -- Dynamically load env vars from .zshrc or similar
    settings = {
      bashIde = {
        enableEnvironmentVarsCompletion = true,
      },
    },
  },
}
