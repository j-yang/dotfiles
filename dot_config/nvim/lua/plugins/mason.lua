return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "basedpyright",
        "debugpy",
        "stylua",
        "shellcheck",
        "shfmt",
      },
    },
  },
}
