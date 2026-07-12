-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- ~/.config/nvim/lua/config/options.lua
-- 启用真彩色（关键！否则主题颜色会失真）
vim.opt.termguicolors = true

vim.opt.cursorline = true
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250"

vim.opt.clipboard = "unnamedplus"

vim.g.python3_host_prog = vim.fn.exepath("python3")
