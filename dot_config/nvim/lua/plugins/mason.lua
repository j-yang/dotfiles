return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "basedpyright",
        "debugpy",
        "ruff",
        "stylua",
        "shellcheck",
        "shfmt",
      },
    },
  },
}
