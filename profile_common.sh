
# change PATH order
PATH=/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/sbin:/usr/sbin:/usr/local/git/bin

# add commands to PATH
PATH=$HOME/bin:$PATH:$HOME/.dotfiles/bin

# add brew commands 
PATH=$PATH:/opt/homebrew/bin

# Homebrew
export HOMEBREW_GITHUB_API_TOKEN="be804c756700b3089b58f570c149bf9e0d2726ff"

# set editor to emacs style
EDITOR=emacs

OS=`uname | tr '[A-Z]' '[a-z]'`

if [[ "${OS}" == "windowsnt" ]]; then
	OS=windows
elif [[ "${OS}" == "darwin" ]]; then
	OS=mac
        ulimit -S -n 1024
elif [[ "${OS}" == "linux" ]]; then
	OS=linux
fi

readonly OS


# pyenv
export PYENV_ROOT="/usr/local/var/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if which pyenv > /dev/null; then
    eval "$(pyenv init --path)"
fi

# virtual env
source ~/.dotfiles/virtualenv-autoenv.sh
