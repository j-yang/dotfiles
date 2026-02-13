return {
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      -- Use the globally installed debugpy with the correct Python path
      local python_path = vim.fn.exepath("python3") or vim.fn.exepath("python") or "python3"
      require("dap-python").setup(python_path)
    end,
  },
}
