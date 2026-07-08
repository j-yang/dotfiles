# Jimmy's Dev Environment

macOS (Apple Silicon) 上的个人开发环境。三大支柱：
**Homebrew**（系统工具/GUI 字体）、**mise**（语言运行时）、**chezmoi**（dotfiles 同步）。
终端栈：Ghostty + zellij + zsh，编辑器 Neovim (LazyVim)，窗口管理 AeroSpace。

## 目录

- [职责划分](#职责划分)
- [语言运行时（mise）](#语言运行时mise)
- [系统工具（Homebrew）](#系统工具homebrew)
- [Dotfiles（chezmoi）](#dotfileschezmoi)
- [密钥与 Token](#密钥与-token)
- [日常命令](#日常命令)
- [项目约定](#项目约定)
- [全新机器引导](#全新机器引导)

## 职责划分

| 层 | 工具 | 职责 |
|---|---|---|
| 系统层 | Homebrew (`brew`) | 命令行工具、GUI 应用、字体。**不**装语言运行时（node/python/go/rust/uv 全归 mise） |
| 语言层 | mise | Python / Node / Go / Rust / uv 的版本管理。全局配置 `~/.config/mise/config.toml` |
| 配置层 | chezmoi | dotfiles 版本控制，源在 `~/.local/share/chezmoi`，push 到 `github.com:j-yang/dotfiles` |

## 语言运行时（mise）

`~/.config/mise/config.toml`：

```toml
[tools]
python = "3.12"
node   = "lts"
uv     = "latest"
rust   = "latest"
go     = "latest"

[settings]
experimental = true
```

- 通过 `eval "$(mise activate zsh)"` 注入 PATH，shims 优先级最高。
- `mise ls` 看已装版本，`mise use -g <tool>@<ver>` 改全局，`mise install` 装所有。
- rust 走 rustup 后端（`~/.cargo/bin`），mise 仅登记版本号。
- ⚠️ **坑**：`mise use -g` 改的是 `~/.config/mise/config.toml`（已由 chezmoi 纳管）。改完务必 `chezmoi re-add ~/.config/mise/config.toml` 同步到源，否则下次 `chezmoi apply` 会用旧源覆盖、把新增运行时丢掉。

## 系统工具（Homebrew）

两份清单（`install.sh` 依次读取）：
- `Brewfile` —— 命令行工具（eza/fd/bat/ripgrep/fzf/zoxide/starship/delta/atuin/direnv/lazygit/lazydocker/duckdb/neovim/zellij/opencode …）
- `Brewfile.casks` —— GUI 应用 + 字体（Ghostty/AeroSpace/Obsidian/OrbStack/Raycast/Tailscale/font-maple-mono-nf-cn …）

> 原则：语言运行时绝不写进 Brewfile，避免和 mise 重复遮蔽。

重新生成：`brew bundle dump --force --file ~/Brewfile`（注意需在有 mise 的交互 shell 里跑，否则 `go`/`npm` 等条目会丢失）。

## Dotfiles（chezmoi）

- 源目录：`~/.local/share/chezmoi`
- 常用命令：`chezmoi diff`（看差异）、`chezmoi update`（拉远程）、`chezmoi apply`（写回本机）、`chezmoi edit`（编辑源）。
- 改完源记得 `chezmoi apply`，改完本机想纳管用 `chezmoi add <path>`。
- 重点纳管项：`dot_zshrc.tmpl`、`dot_gitconfig`、`dot_config/nvim`(LazyVim)、`dot_config/zellij`、`dot_config/ghostty`、`dot_config/aerospace`、`dot_config/yazi`、`dot_config/mise`、`Brewfile(.casks)`。

### Neovim (LazyVim)

- 配置在 `~/.config/nvim`，由 chezmoi 纳管（磁盘为准）。
- 主题 tokyonight-storm；格式化 ruff（conform.nvim）；LSP basedpyright + rust_analyzer；DAP 走 Mason debugpy；调试/测试 neotest。
- **不要**往 `~/.config/nvim` 放 `*.md` / `test_*.py` / cache —— 这些被 `.chezmoiignore` 排除，且会污染编辑器配置目录。

## 密钥与 Token（age 加密，跨设备同步）

所有 secret（GitHub PAT / npm / crates.io 等）加密存进 git 仓库，随 chezmoi 同步到每台机器；私钥仅本机持有、**不**提交。

| 文件 | 作用 | 是否提交 |
|---|---|---|
| `~/.config/secrets/secrets.age` | 密文 secrets（chezmoi 纳管，`private_` → 0600） | ✅ 加密后提交 |
| `~/.config/chezmoi/age-key.txt` | age 私钥（本机独有） | ❌ 已在 `.chezmoiignore` |

zshrc 启动时 `age -d` 在内存解密并 `eval`，**不**落明文文件。

日常管理（zsh 函数）：
```bash
secrets edit   # 解密到临时文件 → 编辑 → 重新加密
secrets show   # 解密到 stdout 查看
```
文件格式（一行一个 export）：
```
export HOMEBREW_GITHUB_API_TOKEN="ghp_xxx"
export NPM_TOKEN="npm_xxx"
export CARGO_REGISTRY_TOKEN="cry_xxx"
```

工具集成：
- **npm**：`~/.config/npm/npmrc` 里写 `//registry.npmjs.org/:_authToken=${NPM_TOKEN}`，zsh 启动时由 age 注入 `NPM_TOKEN`。
- **crates.io**：`~/.cargo/config.toml` 设 `global-credential-providers = ["cargo:macos-keychain","cargo:token"]`；或把 `CARGO_REGISTRY_TOKEN` 放进 secrets.age。

### 新增一台机器
1. `chezmoi init --apply j-yang` —— 拉到密文 `secrets.age`。
2. 把原机器的 `~/.config/chezmoi/age-key.txt` **安全拷到新机器同路径**（AirDrop / U 盘，勿走公网明文）。
3. 重开 shell，`echo $HOMEBREW_GITHUB_API_TOKEN` 应有值。

## 日常命令

| 命令 | 作用 |
|---|---|
| `proxy_on` / `proxy_off` | 开/关 clash 代理（127.0.0.1:7890/7891） |
| `cd` (→ zoxide) / `zi` | 智能跳目录 / fzf 交互选 |
| `ff` / `vf` / `fh` / `fd` / `rgf` | fzf 找文件 / nvim 打开 / 历史 / 目录 / 内容 |
| `lazygit` / `lazydocker` | TUI git / docker |
| `ll` / `la` / `lt` | eza 列表 / 全部 / 树 |
| `y` | yazi 文件管理（退出回原目录） |
| `v` | nvim |
| `Ctrl-R` | **atuin** 历史搜索 |

## 项目约定

所有代码在 `~/projects`。环境管理**统一用 mise**，每个项目放 `.mise.toml` pin 版本：

```toml
[tools]
python = "3.12"
```

- 不要再用 `.nvmrc` / `.python-version` / `.tool-versions` —— 由 `.mise.toml` 统一。
- Python 项目用 `uv`（`uv.lock` 锁定），不要混用 `requirements.txt`。
- 进项目目录时 `direnv` 自动激活 `.envrc` / venv（如配置）。

## 全新机器引导

```bash
# 1. 装 Homebrew（见 brew.sh 官方）
# 2. 一键引导（装 chezmoi + brew 包 + mise 工具 + nvim 插件）
sh -c "$(curl -fsLS https://raw.githubusercontent.com/j-yang/dotfiles/main/install.sh)"
# 或已有 chezmoi：chezmoi init --apply j-yang
# 3. 把 age 私钥拷到 ~/.config/chezmoi/age-key.txt（从另一台机器安全复制）
# 4. atuin 历史（可选同步）：atuin import auto && atuin sync
```
