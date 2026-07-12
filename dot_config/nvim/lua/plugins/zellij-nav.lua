return {
  "swaits/zellij-nav.nvim",
  event = "VeryLazy",
  keys = {
    { "<c-h>", "<cmd>ZellijNavigateLeft<cr>",  silent = true, desc = "Window/Zellij left" },
    { "<c-j>", "<cmd>ZellijNavigateDown<cr>",  silent = true, desc = "Window/Zellij down" },
    { "<c-k>", "<cmd>ZellijNavigateUp<cr>",    silent = true, desc = "Window/Zellij up" },
    { "<c-l>", "<cmd>ZellijNavigateRight<cr>", silent = true, desc = "Window/Zellij right" },
  },
  opts = {},
}
