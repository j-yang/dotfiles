-- ~/.config/nvim/lua/plugins/theme.lua
return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "storm",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-storm",
    },
  },

  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    opts = {
      enable = true,
      extra_groups = { "Normal", "NormalNC", "NeoTreeNormal" },
      exclude_groups = {
        "TokyoNight*",
        "StatusLine",
        "WinBar",
        "Cursor",
        "lCursor",
        "CursorLine",
        "CursorColumn",
        "Visual",
        "TermCursor",
        "TermCursorNC",
        "Snacks*",
      },
    },
    config = function(_, opts)
      local ok, transparent = pcall(require, "transparent")
      if not ok then
        return
      end
      transparent.setup(opts)
      vim.defer_fn(function()
        transparent.toggle(true)
      end, 200)
    end,
  },
}
