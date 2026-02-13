# Yazi Configuration - Gruvbox Dark Theme

## 配置完成 ✅

### 文件结构
```
~/.config/yazi/
├── yazi.toml          # 主配置文件
├── theme.toml         # 主题配置 (使用 gruvbox-dark)
├── keymap.toml        # 键位绑定
├── flavors/
│   └── gruvbox-dark/
│       └── flavor.toml # Gruvbox Dark 主题定义
└── README.md          # 本文件
```

### 主题特性

**Gruvbox Dark 配色方案:**
- 背景: #282828 (warm dark)
- 前景: #ebdbb2 (light cream)
- 强调色:
  - 目录: #83a598 (blue)
  - 文件: #ebdbb2 (cream)
  - 可执行: #b8bb26 (green)
  - 符号链接: #8ec07c (aqua)
  - 媒体: #fe8019 (orange)
  - 归档: #fb4934 (red)
  - 文档: #d3869b (purple)

### 键位绑定 (Vim-style)

**导航:**
- `hjkl` / 方向键 - 移动
- `gg` / `G` - 顶部/底部
- `Ctrl-u` / `Ctrl-d` - 半页上下
- `H` / `L` - 后退/前进

**文件操作:**
- `o` / `Enter` - 打开
- `y` - 复制
- `x` - 剪切
- `p` - 粘贴
- `d` - 删除到回收站
- `D` - 永久删除
- `a` - 创建文件/目录
- `r` - 重命名

**选择:**
- `Space` - 切换选择
- `v` - 视觉模式
- `Ctrl-a` - 全选
- `Ctrl-r` - 反选

**搜索:**
- `s` - 搜索文件 (fd)
- `S` - 搜索内容 (ripgrep)
- `/` - 查找
- `n` / `N` - 下一个/上一个

**快捷跳转:**
- `gh` - Home (~)
- `gc` - Config (~/.config)
- `gd` - Downloads
- `gD` - Documents
- `gp` - Projects
- `z` - FZF 跳转
- `Z` - Zoxide 跳转

**标签页:**
- `t` - 新建标签
- `1-5` - 切换到标签 1-5
- `[` / `]` - 上一个/下一个标签

**其他:**
- `.` - 显示/隐藏隐藏文件
- `f` - 过滤
- `w` - 任务管理器
- `;` - Shell
- `:` - Shell (阻塞)
- `~` - 帮助
- `q` - 退出

### 使用方法

**启动 Yazi:**
```bash
y          # 使用 wrapper (退出时 cd 到当前目录)
yazi       # 直接启动
```

**功能特性:**
- ✅ Gruvbox Dark 主题
- ✅ 显示 Git 状态
- ✅ 图标支持
- ✅ 文件预览 (代码、图片、视频等)
- ✅ 快速搜索和过滤
- ✅ FZF/Zoxide 集成
- ✅ 智能文件打开器

### 预览支持

需要安装以下工具以获得最佳预览体验:
```bash
brew install bat           # 代码高亮
brew install ffmpegthumbnailer  # 视频缩略图
brew install fd            # 文件搜索
brew install ripgrep       # 内容搜索
brew install poppler       # PDF 预览
brew install imagemagick   # 图片处理
```

### 自定义

要修改主题颜色，编辑:
```
~/.config/yazi/flavors/gruvbox-dark/flavor.toml
```

要修改键位绑定，编辑:
```
~/.config/yazi/keymap.toml
```

要修改行为，编辑:
```
~/.config/yazi/yazi.toml
```

---

**参考:**
- Yazi 官方文档: https://yazi-rs.github.io/
- Gruvbox 配色: https://github.com/morhetz/gruvbox
