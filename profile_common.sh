
# change PATH order
PATH=/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/sbin:/usr/sbin:/usr/local/git/bin

# add commands to PATH
PATH=$PATH:$HOME/.dotfiles/bin:$HOME/bin

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
