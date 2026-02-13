-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- ~/.config/nvim/lua/config/options.lua
-- 启用真彩色（关键！否则主题颜色会失真）
vim.opt.termguicolors = true
-- 配置JetBrains字体（适配Nerd Font，兼容LazyVim图标）
-- 如果你用的是纯JetBrains Mono，改为 "JetBrainsMono:h14" 即可
vim.opt.guifont = "JetBrainsMono Nerd Font:h14"
-- 可选：调整字体渲染（解决模糊问题）
vim.opt.linespace = 0

vim.opt.cursorline = true
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250"

vim.opt.clipboard = "unnamedplus"

vim.g.lazyvim_check_order = false
