return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "basedpyright",
        "debugpy",
        "mypy",
        "ruff",
        "black",
        "stylua",
        "shellcheck",
        "shfmt",
      },
    },
  },
}
