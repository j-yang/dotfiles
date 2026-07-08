return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<C-\\>", "<cmd>ToggleTerm<cr>", mode = { "n", "t" }, desc = "Toggle terminal" },
    { "<leader>rp", function()
      local file = vim.fn.expand("%:p")
      if file == "" then return end
      local term = require("toggleterm.terminal").Terminal:new({
        cmd = "python " .. file,
        direction = "float",
        close_on_exit = false,
      })
      term:toggle()
    end, desc = "Run Python file" },
    { "<leader>s", mode = "v", desc = "Send selection to terminal" },
  },
  opts = {
    shade_terminals = false,
    open_mapping = [[<C-\>]],
    direction = "float",
    float_opts = {
      border = "curved",
    },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)
    local function send_selection()
      local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })
      local text = table.concat(lines, "\n")
      vim.cmd("ToggleTerm")
      vim.fn.chansend(vim.b.terminal_job_id, text .. "\n")
    end
    vim.keymap.set("v", "<leader>s", send_selection, { buffer = false, desc = "Send selection to terminal" })
  end,
}
