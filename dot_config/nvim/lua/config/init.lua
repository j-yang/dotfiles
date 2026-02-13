-- 自动检测系统Python3路径并配置
vim.g.python3_host_prog = vim.fn.exepath("python3")

-- （可选）如果是虚拟环境，手动指定路径（示例）
-- vim.g.python3_host_prog = "~/.venv/bin/python3"
-- vim.g.python3_host_prog = "/usr/local/bin/python3"

require("config.test-cursor")
