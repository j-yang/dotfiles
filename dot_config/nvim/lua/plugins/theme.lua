-- ~/.config/nvim/lua/plugins/theme.lua
return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        transparent_mode = true,
        contrast = "soft",
        palette_overrides = {
          orange = "#d65d0e",
          yellow = "#d79921",
          aqua = "#689d6a",
          blue = "#458588",
        },
      })
    end,
  },

  -- 2. 配置LazyVim使用gruvbox（覆盖原来的default）
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox", -- 核心：切换为gruvbox
      ui = {},
    },
  },

  -- 3. 透明背景（适配gruvbox，避免覆盖配色）
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    opts = {
      enable = true,
      extra_groups = { "Normal", "NormalNC", "NeoTreeNormal" },
      exclude_groups = {
        "Gruvbox*",
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
      end -- 容错：避免模块加载失败报错
      transparent.setup(opts)
      -- 延迟触发，等gruvbox加载完成后再透明（解决冲突）
      vim.defer_fn(function()
        transparent.toggle(true)
      end, 200) -- 延长延迟，确保gruvbox先生效
    end,
  },
}
