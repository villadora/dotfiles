
# change PATH order
PATH=/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/sbin:/usr/sbin:/usr/local/git/bin

# add commands to PATH
PATH=$HOME/bin:$PATH:$HOME/.dotfiles/bin

# Android Home
export ANDROID_HOME=/usr/local/Cellar/android-sdk/24.3.4

# GOPATH
export GOPATH=$HOME/dev/gopath

# Homebrew
export HOMEBREW_GITHUB_API_TOKEN="14dfae85812adbcffe896ce6ad5dbb5c25360909"

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



# add z cmd
source ~/.dotfiles/bash/z/z.sh


function mountAndroid { hdiutil attach ~/dev/vms/android.dmg.sparseimage -mountpoint /Volumes/android; }
