
# change PATH order
PATH=/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/sbin:/usr/sbin:/usr/local/git/bin

# add commands to PATH
PATH=$HOME/bin:$PATH:$HOME/.dotfiles/bin

# add mysql commands 
PATH=$PATH:/usr/local/mysql/bin

# add brew commands 
PATH=$PATH:/opt/homebrew/bin

# Android Home
export ANDROID_HOME=/usr/local/Cellar/android-sdk/24.3.4

# GOPATH
export GOPATH=$HOME/dev/go

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


# kdb q
export QHOME="~/.dotfiles/bin/q"
export PATH=$PATH:$QHOME/m32



# add z cmd
source ~/.dotfiles/bash/z/z.sh


# function mountAndroid { hdiutil attach ~/dev/vms/android.dmg.sparseimage -mountpoint /Volumes/android; }

export PYENV_ROOT=/usr/local/var/pyenv
if which pyenv > /dev/null; then
    eval "$(pyenv init -)";
fi

# virtual env
source ~/.dotfiles/virtualenv-autoenv.sh
