# Mac 开发环境初始化指南

本文档按照**依赖顺序**组织，优先安装底层工具，再安装上层应用。

---

## 0. 快速开始

### 一键完整安装

```bash
# 1. 安装 Xcode CLT
xcode-select --install

# 2. 克隆并运行 bootstrap
git clone https://github.com/villadora/dotfiles.git ~/.dotfiles && cd ~/.dotfiles && ./bootstrap
```

---

## 1. Homebrew (基础包管理器)

### 安装

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 配置镜像源 (清华源)

```bash
git -C "$(brew --repo)" remote set-url origin https://mirrors.tongji.edu.cn/homebrew/brew.git
git -C "$(brew --repo homebrew/core)" remote set-url origin https://mirrors.tongji.edu.cn/homebrew/homebrew-core.git
git -C "$(brew --repo homebrew/cask)" remote set-url origin https://mirrors.tongji.edu.cn/homebrew/homebrew-cask.git
git -C "$(brew --repo homebrew/services)" remote set-url origin https://mirrors.tongji.edu.cn/homebrew/homebrew-services.git
brew update
```

### 通过 Homebrew 安装常用包

以下步骤已集成到 `bootstrap` 脚本中自动执行:

```bash
./bootstrap  # 会自动安装: z, git-extras, newman, python@3.13, maven, gradle, cmake, warp, docker, ccswitch, gemini-cli, mole, reattach-to-user-namespace
```

如需单独安装:
```bash
brew install z git-extras newman python@3.13 maven gradle cmake
brew install --cask warp docker
brew install mole reattach-to-user-namespace
```

---

## 2. Git (版本管理)

### 安装

macOS 自带 Git，也可通过 Homebrew 更新:

```bash
brew install git
```

### 配置

**配置文件**: `~/.gitconfig` (链接自 `~/.dotfiles/git/gitconfig.symlink`)

**用户信息**:
```bash
git config --global user.name "villadora"
git config --global user.email "jky239@gmail.com"
```

**常用别名**:
```
ga      -> git add
gca     -> git commit -am
gst     -> git status
gl      -> git lg
co      -> checkout
ci      -> commit
lg      -> log --pretty=format:'%Cred%h%Creset -%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'
lol     -> log --graph --decorate --pretty=oneline --abbrev-commit
```

---

## 3. zsh + oh-my-zsh (Shell 环境)

### 安装 oh-my-zsh

```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
```

### oh-my-zsh 插件

在 `~/.dotfiles/zshrc.symlink` 的 plugins 数组中配置:

```zsh
plugins=(
    git github git-extras brew history ssh mvn z
    poetry pyenv history-substring-search docker docker-compose
    npm nvm pip
)
```

### zsh 配置

**配置文件**: `~/.zshrc` (链接自 `~/.dotfiles/zshrc.symlink`)

包含: pyenv 初始化、nvm 加载、pnpm 配置、代理函数等


**代理配置**:
```bash
proxy_on    # 开启终端代理 (http_proxy=http://127.0.0.1:7890)
proxy_off   # 关闭终端代理
```

### 配置文件加载顺序

```
~/.zshenv
  └── HAPPY_SERVER_URL

~/.zshrc
  ├── ZSH=$HOME/.oh-my-zsh
  ├── oh-my-zsh + plugins
  ├── pyenv init
  ├── nvm init
  ├── $HOME/.dotfiles/local_env.sh (optional)
  ├── pnpm
  ├── $HOME/.dotfiles/tokens_env.sh
  ├── Claude CLI (~/.clauderc)
  └── Cargo env
```

---

## 4. tmux (终端复用器)

### 安装 tmux

```bash
brew install tmux
```

### 安装 TPM (tmux 插件管理器)

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### 安装 reattach-to-user-namespace (剪贴板支持)

在 bootstrap 中自动安装。

### tmux 配置

**配置文件**: `~/.tmux.conf` (链接自 `~/.dotfiles/tmux.conf.symlink`)

**用户覆盖配置**: `~/.tmux.conf.local` (空白文件，由 bootstrap 创建)

**已配置插件** (通过 TPM 安装):
- `tmux-plugins/tmux-sensible` - 基础配置集合
- `b0o/tmux-autoreload` - 自动重载配置
- `tmux-plugins/tmux-battery` - 电池状态
- `tmux-plugins/tmux-cpu` - CPU 状态
- `sainnhe/tmux-fzf` - FZF 集成
- `jaclu/tmux-menus` - 菜单
- `tmux-plugins/tmux-sidebar` - 侧边栏
- `ofirgall/tmux-window-name` - 窗口命名
- `tmux-plugins/tmux-resurrect` - 会话恢复
- `tmux-plugins/tmux-continuum` - 自动保存恢复
- `tmux-plugins/tmux-open` - 快速打开
- `tmux-plugins/tmux-yank` - 剪贴板集成
- `tmux-plugins/tmux-logging` - 日志记录

**快捷键**:
- `C-o` - 前缀键 (替代默认 C-b)
- `C-]` / `C-\` - 窗口导航
- `Tab` - 最后活跃窗口
- `Enter` - 复制模式
- `m` - 切换鼠标

---

## 5. pyenv (Python 版本管理)

### 安装

```bash
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
```

### 配置

在 `~/.zshrc` 中已配置:
```zsh
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
```

### 使用 venv 管理虚拟环境

Python 3.3+ 内置 venv 模块:

```bash
python3 -m venv myenv              # 创建虚拟环境
source myenv/bin/activate         # 激活虚拟环境
deactivate                        # 退出虚拟环境
```

配合 pyenv 使用:
```bash
pyenv install 3.12.0               # 安装 Python 版本
pyenv global 3.12.0               # 设置全局版本
cd myproject
python3 -m venv .venv             # 在项目目录创建 venv
source .venv/bin/activate         # 激活
```

**自动激活**: 在项目根目录创建 `.python-version` 文件，pyenv 会自动激活对应虚拟环境

---

## 6. nvm (Node 版本管理)

### 安装

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
```

### 配置

在 `~/.zshrc` 中已配置:
```zsh
source "$HOME/.nvm/nvm.sh"
export PNPM_HOME="$HOME/Library/pnpm"
```

### 使用

```bash
nvm install 20              # 安装 Node 版本
nvm use --default           # 设置默认版本
```

---

## 7. jenv (Java 版本管理)

### 安装

```bash
git clone https://github.com/jenv/jenv.git ~/.jenv
```

### 配置

在 `~/.zshrc` 中已配置 (通过 oh-my-zsh jenv 插件)

### 使用

```bash
jenv add $(/usr/libexec/java_home -v 11)  # 添加 Java 版本
jenv global 11                             # 设置默认版本
```

---

## 8. Emacs (编辑器)

### 安装

```bash
brew install emacs
```

### 配置

**spaceemacs**: 参考 https://github.com/syl20bnr/spacemacs

**配置文件**: `~/.dotfiles/zshrc.symlink` 中定义别名:
```zsh
alias emacs="emacs -nw"
alias ec="emacsclient -nw"
```

**Daemon 脚本**: `~/.dotfiles/bin/emacs-daemon`

---

## 9. Docker

### 安装

参考: https://docs.docker.com/docker-for-mac/install/

在 bootstrap 中自动安装 Docker (cask)。

### 配置

```bash
eval "$(docker-machine env default)"  # 设置 Docker Machine 环境
```

**相关脚本**:
- `docker-run-default` - 初始化 Docker 环境
- `docker-clean` - 清理 Docker 资源

---

## 10. CLI 工具

以下步骤已集成到 `bootstrap` 脚本中自动执行。

### Claude Code / ccswitch (模型切换)

ccswitch 在 bootstrap 中自动安装。

### Gemini CLI

Gemini CLI 在 bootstrap 中自动安装。

### Codex CLI

参考: https://github.com/sourcegraph/codex

### Mole (软件清理)

Mole 在 bootstrap 中自动安装。

### Warp (终端)

Warp 在 bootstrap 中自动安装。

### 其他 brew 工具

| 工具 | 命令 |
|------|------|
| z | `brew install z` |
| git-extras | `brew install git-extras` |
| newman | `brew install newman` |
| reattach-to-user-namespace | `brew install reattach-to-user-namespace` |

---

## 11. Bootstrap 部署脚本

执行 `./bootstrap` 自动完成以下初始化 (幂等):

```
setup_gitconfig        → 创建 ~/.gitconfig
install_dotfiles       → 创建所有 symlink
install_tmux_conf_local → 创建 ~/.tmux.conf.local
install_homebrew       → 安装 Homebrew
install_oh_my_zsh      → 安装 oh-my-zsh
install_pyenv          → 安装 pyenv
setup_python_env       → 交互式 Python 配置
install_jenv           → 安装 jenv
install_nvm            → 安装 nvm
install_tmux_plugins   → 安装 TPM
install_via_brew       → 安装 z, git-extras, newman
install_brew_packages  → 安装 python@3.13, maven, gradle, cmake
install_brew_casks     → 安装 warp, docker
install_reattach_to_user_namespace → 安装剪贴板支持
install_homebrew_taps  → 安装 ccswitch tap
install_ccswitch      → 安装 Claude 模型切换工具
install_gemini_cli     → 安装 Gemini CLI
install_mole           → 安装软件清理工具
```

### symlink 文件清单

| 源文件 | 目标路径 |
|--------|----------|
| `zshrc.symlink` | `~/.zshrc` |
| `tmux.conf.symlink` | `~/.tmux.conf` |
| `bash_aliases.symlink` | `~/.bash_aliases` |
| `bash_profile.symlink` | `~/.bash_profile` |
| `bashrc.symlink` | `~/.bashrc` |
| `zprofile.symlink` | `~/.zprofile` |
| `git/gitconfig.symlink` | `~/.gitconfig` |
| `git/gitignore_global.symlink` | `~/.gitignore_global` |
| `jshintrc.symlink` | `~/.jshintrc` |
| `mavenrc.symlink` | `~/.mavenrc` |

---

## 12. 环境变量

### tokens_env.sh (敏感信息)

在 `~/.dotfiles/tokens_env.sh` 中配置:

```bash
export HOMEBREW_GITHUB_API_TOKEN="<token>"  # Optional
export BAIDU_API_KEY="<key>"                 # Optional
```

### profile_common.sh (自动加载)

```bash
NVM_DIR=$HOME/.nvm
JAVA_HOME  # Set by jenv
PNPM_HOME=$HOME/Library/pnpm
```

---

## 13. 常见问题排查

### 重新加载 shell 配置

```bash
source ~/.zshrc    # Zsh
source ~/.bash_profile  # Bash
```

### 检查 PATH 重复

```bash
echo $PATH | tr ':' '\n' | sort | uniq -d
```

### 验证 symlinks

```bash
ls -la ~/*.symlink
```

### 重新安装 tmux 插件

```bash
rm -rf ~/.tmux/plugins/*
tmux  # 然后按 Ctrl+b Shift+i
```

### 检查版本管理器状态

```bash
# nvm
source ~/.nvm/nvm.sh && nvm list

# pyenv
pyenv versions

# jenv
jenv versions
```

---

## 快速检查清单

```bash
# Shell
echo $SHELL        # /bin/zsh
echo $ZSH_VERSION

# Git
git --version

# Homebrew
brew --version

# Python
pyenv --version
python3 --version

# Node
nvm --version
node --version
pnpm --version

# Java
jenv version
mvn --version

# Docker
docker --version
docker-compose --version

# tmux
tmux -V
```

---

## 配置文件速查

| 配置 | 源文件 | 目标路径 |
|------|--------|----------|
| zshrc | `zshrc.symlink` | `~/.zshrc` |
| tmux | `tmux.conf.symlink` | `~/.tmux.conf` |
| tmux 本地覆盖 | *(手动创建)* | `~/.tmux.conf.local` |
| gitconfig | `git/gitconfig.symlink` | `~/.gitconfig` |
| gitignore | `git/gitignore_global.symlink` | `~/.gitignore_global` |
| bash aliases | `bash_aliases.symlink` | `~/.bash_aliases` |
| mavenrc | `mavenrc.symlink` | `~/.mavenrc` |
| jshintrc | `jshintrc.symlink` | `~/.jshintrc` |
| 自定义脚本 | `bin/*` | `~/.dotfiles/bin/` |

---

## 工具清单

### 版本管理器

| 工具 | 用途 | 配置文件 |
|------|------|----------|
| pyenv | Python 版本管理 | `zshrc.symlink` |
| jenv | Java 版本管理 | `profile_common.sh` |
| nvm | Node.js 版本管理 | `zshrc.symlink` |

### Python 生态

| 工具 | 用途 | 配置文件 |
|------|------|----------|
| Poetry | 包管理 | oh-my-zsh 插件 |
| pipx | CLI 工具隔离 | `profile_common.sh` |
| uv | 快速包安装 | 手动 |
| venv | 虚拟环境 | Python 内置模块 |
| pyenv | Python 版本管理 | `zshrc.symlink` |

### Node 生态

| 工具 | 用途 | 配置文件 |
|------|------|----------|
| npm | 包管理 | oh-my-zsh 插件 |
| pnpm | 快速包管理 | `zshrc.symlink` |
| nvm | Node 版本管理 | `zshrc.symlink` |

### Java 生态

| 工具 | 用途 | 配置文件 |
|------|------|----------|
| Maven | 构建工具 | oh-my-zsh 插件 |
| Gradle | 构建工具 | brew |
| jenv | Java 版本管理 | `profile_common.sh` |

### Shell & 终端

| 工具 | 用途 | 配置文件 |
|------|------|----------|
| Oh My Zsh | Zsh 框架 | `zshrc.symlink` |
| tmux | 终端复用器 | `tmux.conf.symlink` |
| TPM | tmux 插件管理 | 手动安装 |
| z | 目录跳转 | oh-my-zsh 插件 |
| htop | 进程查看 | brew |
| ripgrep | 快速 grep | brew |

### Git 工具

| 工具 | 用途 | 配置文件 |
|------|------|----------|
| git | 版本控制 | 全局 |
| git-extras | 扩展命令 | oh-my-zsh 插件 |
| hub | GitHub CLI | brew |
| git-lfs | 大文件支持 | brew |

### 编辑器

| 工具 | 用途 | 配置文件 |
|------|------|----------|
| Emacs | 编辑器 | `bash_aliases.symlink` |
| JetBrains | IDE | `bash_profile.symlink` |

---

## Shell 别名

```bash
# 导航
ll='ls -alF', la='ls -A', l='ls -CF'

# 安全
mv="mv -i", cp="cp -i"

# 编辑器
emacs="emacs -nw", ec="emacsclient -nw"

# Git
gti="git", ga="git add", gca="git commit -am"
gst="git st", gl="git lg"

# SSH
sshzu='ssh -t $* "export LANG=zh_CN.utf8;bash"'

# Docker
docker-run-default='eval "$(docker-machine env default)"'
```

---

## 14. Oh My Zsh 插件列表

```
git, github, git-extras, brew, history, ssh, mvn,
z, poetry, pyenv,
history-substring-search, docker, docker-compose,
npm, nvm, pip
```

---

## 15. tmux 插件列表 (通过 TPM)

```
tmux-continuum, tmux-resurrect, tmux-battery,
tmux-cpu, tmux-sidebar, tmux-window-name,
tmux-fzf, tmux-menus, tmux-sensible,
tmux-yank, tmux-autoreload, tpm
```

---

## 16. Shell 工具 (bin/)

```
git-cal, git-m, git-loc, git-clone-branch,
git-chauthor, git-sch, git-perm-rm,
emacs-daemon, tmux-resurrect, docker-clean,
proxy, safe-reattach-to-user-namespace
```

---

## 17. 其他工具

| 工具 | 用途 | 安装方式 |
|------|------|----------|
| Claude CLI | AI 助手 | claude.ai |
| web3j | Ethereum 工具 | 手动安装 |
| Warp | 终端 | `brew install --cask warp` |
| Conda | Python 发行版 | anaconda.com |

---

## 18. Symlink 结构

```
~/.dotfiles/
├── zshrc.symlink              → ~/.zshrc
├── bash_profile.symlink       → ~/.bash_profile
├── bashrc.symlink             → ~/.bashrc
├── bash_aliases.symlink       → ~/.bash_aliases
├── zprofile.symlink           → ~/.zprofile
├── tmux.conf.symlink          → ~/.tmux.conf
├── mavenrc.symlink            → ~/.mavenrc
├── jshintrc.symlink           → ~/.jshintrc
├── git/gitconfig.symlink       → ~/.gitconfig
└── git/gitignore_global.symlink → ~/.gitignore_global
```

---

## 19. Bash 配置文件加载顺序

```
~/.bash_profile
  ├── PROMPT_COMMAND (terminal title)
  ├── PATH setup
  ├── profile_common.sh
  │   ├── PATH (system, homebrew, pipx)
  │   ├── EDITOR=emacs
  │   ├── OS detection
  │   └── jenv init
  ├── tokens_env.sh
  ├── conda init
  ├── JetBrains vmoptions (optional)
  ├── web3j source (optional)
  └── Cargo env
```
