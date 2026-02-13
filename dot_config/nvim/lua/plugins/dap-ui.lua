return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    opts = {
      -- Enhanced sidebar layout
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.30 },      -- Variables
            { id = "breakpoints", size = 0.20 }, -- Breakpoints list
            { id = "stacks", size = 0.30 },      -- Call stack
            { id = "watches", size = 0.20 },     -- Watch expressions
          },
          size = 50,        -- Wider sidebar for better visibility
          position = "left",
        },
        {
          elements = {
            { id = "repl", size = 0.5 },
            { id = "console", size = 0.5 },
          },
          size = 12,
          position = "bottom",
        },
      },
      
      -- Controls for mouse interaction
      controls = {
        enabled = true,
        element = "repl",
        icons = {
          pause = "",
          play = "",
          step_into = "",
          step_over = "",
          step_out = "",
          step_back = "",
          run_last = "",
          terminate = "",
          disconnect = "",
        },
      },
      
      -- Floating windows config
      floating = {
        max_height = 0.9,
        max_width = 0.9,
        border = "rounded",
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      
      -- Window settings
      windows = { indent = 1 },
      
      -- Render settings
      render = {
        max_type_length = nil,
        max_value_lines = 100,
      },
    },
    
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      
      dapui.setup(opts)
      
      -- Auto-open UI when debugging starts
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      
      -- Auto-close UI when debugging ends
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
}
