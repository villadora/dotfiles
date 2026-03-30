# Dotfiles Setup Guide

This guide enables Claude Code (or any AI agent) to bootstrap a fresh Mac with a complete development environment.

## Phase 0: One-Command Full Setup

For maximum agent efficiency, the entire setup can be done with:

```bash
# 1. Install Xcode CLT
xcode-select --install

# 2. Clone and run bootstrap
git clone https://github.com/villadora/dotfiles.git ~/.dotfiles && cd ~/.dotfiles && ./bootstrap
```

Then follow Phase 3 (Post-Bootstrap Setup) for manual steps.

---

## Phase 1: Bootstrap (Automated)

### Run Bootstrap

```bash
./bootstrap
```

This **idempotent** script runs sequentially, skipping already-installed components:

| # | Installs | Skip If |
|---|----------|---------|
| 1 | Gitconfig | `git/gitconfig.symlink` exists |
| 2 | Dotfile symlinks | Already linked |
| 3 | Homebrew | `brew` exists |
| 4 | Oh My Zsh | `~/.oh-my-zsh` exists |
| 5 | pyenv | `~/.pyenv` exists |
| 6 | jenv | `~/.jenv` exists |
| 7 | nvm | `~/.nvm/nvm.sh` exists |
| 8 | TPM (tmux plugins) | `~/.tmux/plugins/tpm/tpm` exists |
| 9 | Brew packages | Already installed |

Safe to **re-run if interrupted**.

---

## Phase 2: Manual Tool Installation

### 2.1 Core Version Managers

```bash
# Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# pyenv (Python)
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

# jenv (Java)
git clone https://github.com/jenv/jenv.git ~/.jenv

# nvm (Node.js)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# SDKMAN (Java/Kotlin)
curl -s "https://get.sdkman.io" | bash

# TPM (tmux plugins)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### 2.2 Homebrew Packages

Install all packages in one command:

```bash
brew install \
  git git-extras git-lfs hub \
  z tmux htop ripgrep tree \
  python@3.13 node npm \
  maven gradle \
  openjdk@21 \
  poetry pipx uv \
  cmake \
  newman
```

Or install individually:

```bash
brew install git git-extras git-lfs hub
brew install z tmux htop ripgrep tree
brew install python@3.13 node npm
brew install maven gradle openjdk@21
brew install poetry pipx uv cmake
brew install newman
```

### 2.3 Optional Heavy Tools (via Homebrew Cask)

```bash
brew install --cask \
  emacs sublime-text zed warp \
  docker
```

### 2.4 Rust (rustup)

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

---

## Phase 3: Post-Bootstrap Setup

### 3.1 Configure Git

```bash
# Set global identity
git config --global user.name "Your Name"
git config --global user.email "you@example.com"

# Set global gitignore
git config --global core.excludesfile ~/.gitignore_global
```

### 3.2 Create Sensitive Tokens File

```bash
cat > ~/.dotfiles/tokens_env.sh << 'EOF'
# Add your sensitive tokens here - this file is .gitignored
export HOMEBREW_GITHUB_API_TOKEN=""
export BAIDU_API_KEY=""
EOF
```

### 3.3 Install TPM Plugins (tmux)

```bash
tmux
# Then press: Ctrl+b then Shift+i (capital I)
```

### 3.4 Install Programming Language Runtimes

**Python:**
```bash
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
pyenv install 3.11.0
pyenv global 3.11.0
```

**Node.js:**
```bash
source ~/.nvm/nvm.sh
nvm install --lts
nvm use --lts
nvm alias default lts/*
```

**Java (jenv):**
```bash
# Install JDK
brew install openjdk@21

# Add to jenv
jenv add /opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home
jenv global openjdk64-21.0.0
jenv rehash
```

**Java (SDKMAN):**
```bash
source ~/.sdkman/bin/sdkman-init.sh
sdk install java 21.0.2-tem
sdk install gradle
sdk install kotlin
```

---

## Complete Tool Inventory

### Version Managers

| Tool | Purpose | Config File |
|------|---------|------------|
| pyenv | Python version management | `zshrc.symlink` |
| jenv | Java version management | `profile_common.sh` |
| nvm | Node.js version management | `zshrc.symlink` |
| SDKMAN | Java/Kotlin/Gradle | `bash_profile.symlink` |
| conda | Anaconda Python | `bash_profile.symlink` |

### Python Ecosystem

| Tool | Purpose | Config File |
|------|---------|------------|
| Poetry | Package manager | oh-my-zsh plugin |
| pipx | CLI tool isolation | `profile_common.sh` |
| uv | Fast package installer | Manual |
| virtualenv | Environment isolation | oh-my-zsh plugin |
| pyenv | Python version manager | `zshrc.symlink` |

### Node Ecosystem

| Tool | Purpose | Config File |
|------|---------|------------|
| npm | Package manager | oh-my-zsh plugin |
| pnpm | Fast package manager | `zshrc.symlink` |
| nvm | Node version manager | `zshrc.symlink` |

### Java Ecosystem

| Tool | Purpose | Config File |
|------|---------|------------|
| Maven | Build tool | oh-my-zsh plugin |
| Gradle | Build tool | SDKMAN |
| jenv | Java version manager | `profile_common.sh` |

### Shell & Terminal

| Tool | Purpose | Config File |
|------|---------|------------|
| Oh My Zsh | Zsh framework | `zshrc.symlink` |
| tmux | Terminal multiplexer | `tmux.conf.symlink` |
| TPM | tmux plugin manager | Manual install |
| z | Directory jumper | oh-my-zsh plugin |
| htop | Process viewer | brew |
| ripgrep | Fast grep | brew |

### Git Tools

| Tool | Purpose | Config File |
|------|---------|------------|
| git | Version control | Global |
| git-extras | Extended commands | oh-my-zsh plugin |
| hub | GitHub CLI | brew |
| git-lfs | Large files | brew |

### Editors & IDEs

| Tool | Purpose | Config File |
|------|---------|------------|
| Emacs | Editor | `bash_aliases.symlink` |
| JetBrains | IDE | `bash_profile.symlink` |
| Zed | Editor | brew |
| Sublime Text | Editor | brew |

### Additional Tools (Manual Install)

| Tool | Purpose | Config File | Install |
|------|---------|------------|---------|
| Claude CLI | AI assistant | `zshrc.symlink` | claude.ai |
| AsyncAPI CLI | API tooling | `zshrc.symlink` | `npm i -g @asyncapi/cli` |
| web3j | Ethereum tooling | `zshrc.symlink` | SDKMAN |
| Gemini CLI | AI CLI | brew | `brew install gemini-cli` |
| Warp | Terminal | brew | `brew install --cask warp` |
| Conda | Python distribution | `bash_profile.symlink` | anaconda.com |

---

## Symlink Structure

```
~/.dotfiles/
├── zshrc.symlink              → ~/.zshrc
├── bash_profile.symlink       → ~/.bash_profile
├── bashrc.symlink             → ~/.bashrc
├── bash_aliases.symlink       → ~/.bash_aliases
├── zprofile.symlink            → ~/.zprofile
├── tmux.conf.symlink          → ~/.tmux.conf
├── mavenrc.symlink            → ~/.mavenrc
├── jshintrc.symlink           → ~/.jshintrc
├── git/gitconfig.symlink      → ~/.gitconfig
└── git/gitignore_global.symlink → ~/.gitignore_global
```

---

## Configuration Loading Order

### Zsh
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
  ├── AsyncAPI autocomplete
  ├── $HOME/.dotfiles/tokens_env.sh
  ├── Claude CLI (~/.clauderc)
  └── Cargo env
```

### Bash
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
  ├── SDKMAN init
  ├── conda init
  ├── JetBrains vmoptions (optional)
  ├── web3j source (optional)
  └── Cargo env
```

---

## Oh My Zsh Plugins

```
git, github, git-extras, brew, history, ssh, mvn,
z, poetry, pyenv, autoswitch_virtualenv,
history-substring-search, docker, docker-compose,
npm, nvm, pip, virtualenv, virtualenvwrapper
```

---

## tmux Plugins (via TPM)

```
tmux-continuum, tmux-resurrect, tmux-battery,
tmux-cpu, tmux-sidebar, tmux-window-name,
tmux-fzf, tmux-menus, tmux-sensible,
tmux-yank, tmux-autoreload, tpm
```

---

## Shell Tools (bin/)

```
git-cal, git-m, git-loc, git-clone-branch,
git-chauthor, git-sch, git-perm-rm,
emacs-daemon, tmux-resurrect, docker-clean,
proxy, safe-reattach-to-user-namespace
```

---

## Environment Variables

### In `~/.dotfiles/tokens_env.sh` (create this)
```bash
export HOMEBREW_GITHUB_API_TOKEN="<token>"  # Optional
export BAIDU_API_KEY="<key>"                 # Optional
```

### In `~/.zshenv` (already set)
```bash
export HAPPY_SERVER_URL="https://happy.villagao.top"
```

### In `profile_common.sh` (auto-loaded)
```bash
NVM_DIR=$HOME/.nvm
SDKMAN_DIR=$HOME/.sdkman
JAVA_HOME  # Set by jenv
PNPM_HOME=$HOME/Library/pnpm
```

---

## Shell Aliases

```bash
# Navigation
ll='ls -alF', la='ls -A', l='ls -CF'

# Safety
mv="mv -i", cp="cp -i"

# Editors
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

## Troubleshooting

### Reload shell config
```bash
source ~/.zshrc    # Zsh
source ~/.bash_profile  # Bash
```

### Check PATH duplicates
```bash
echo $PATH | tr ':' '\n' | sort | uniq -d
```

### Verify symlinks
```bash
ls -la ~/*.symlink
```

### Reinstall tmux plugins
```bash
rm -rf ~/.tmux/plugins/*
tmux  # Then press Ctrl+b Shift+i
```

### Check version managers
```bash
# nvm
source ~/.nvm/nvm.sh && nvm list

# pyenv
pyenv versions

# jenv
jenv versions

# SDKMAN
source ~/.sdkman/bin/sdkman-init.sh && sdk current
```

---

## Quick Verification Checklist

After setup, verify each tool:

```bash
# Core tools
git --version && brew --version && tmux -V

# Version managers
python --version && node --version && java -version

# Installed tools
which poetry && which pipx && which uv && which pnpm

# Shell
echo $SHELL && echo $EDITOR
```
