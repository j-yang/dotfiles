return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        -- Using ruff only - mypy needs to be reinstalled via Mason
        python = { "ruff" },
      },
    },
  },
}
