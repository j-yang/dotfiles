return {
  {
    "folke/snacks.nvim",
    opts = {
      notifier = {
        style = "compact",
      },
    },
  },
  {
    "gruvbox.nvim",
    opts = function(_, opts)
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "gruvbox",
        callback = function()
          local colors = {
            bg = "#282828",
            fg = "#ebdbb2",
            orange = "#fe8019",
            yellow = "#fabd2f",
            red = "#fb4934",
          }
          
          vim.api.nvim_set_hl(0, "Cursor", { fg = colors.bg, bg = colors.orange, bold = true })
          vim.api.nvim_set_hl(0, "lCursor", { fg = colors.bg, bg = colors.orange, bold = true })
          vim.api.nvim_set_hl(0, "CursorLine", { bg = "#3c3836" })
          vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#3c3836" })
          vim.api.nvim_set_hl(0, "Visual", { bg = "#504945" })
          vim.api.nvim_set_hl(0, "TermCursor", { fg = colors.bg, bg = colors.orange, bold = true })
          vim.api.nvim_set_hl(0, "TermCursorNC", { fg = colors.bg, bg = colors.yellow })
          
          vim.api.nvim_set_hl(0, "SnacksNotifierIconTrace", { fg = colors.fg })
          vim.api.nvim_set_hl(0, "SnacksNotifierTitleTrace", { fg = colors.fg, bold = true })
          vim.api.nvim_set_hl(0, "SnacksNotifierBorderTrace", { fg = colors.fg })
        end,
      })
    end,
  },
}
