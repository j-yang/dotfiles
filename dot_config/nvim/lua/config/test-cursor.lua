vim.api.nvim_create_user_command("TestCursor", function()
  vim.notify("Test notification - Can you see the cursor?", vim.log.levels.INFO)
  vim.notify("Move your cursor in this notification panel", vim.log.levels.WARN)
  vim.notify("Cursor should be visible now!", vim.log.levels.ERROR)
end, {})

vim.api.nvim_create_user_command("ShowNotifications", function()
  require("snacks").notifier.show_history()
end, {})
