return {
  "mrjones2014/smart-splits.nvim",
  lazy = false,
  opts = {
    multiplexer_integration = "zellij",
  },
  keys = {
    { "<c-h>", function() require("smart-splits").move_cursor_left() end, desc = "move left" },
    { "<c-j>", function() require("smart-splits").move_cursor_down() end, desc = "move down" },
    { "<c-k>", function() require("smart-splits").move_cursor_up() end, desc = "move up" },
    { "<c-l>", function() require("smart-splits").move_cursor_right() end, desc = "move right" },
  },
}
