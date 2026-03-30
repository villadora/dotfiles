
# change PATH order
PATH=/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/sbin:/usr/sbin:/usr/local/git/bin

# add commands to PATH
PATH=$HOME/bin:$PATH:$HOME/.dotfiles/bin

# add brew commands
PATH=$PATH:/opt/homebrew/bin

# add pipx commands
PATH=$PATH:$HOME/.local/bin

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


# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"



# virtual env
#source ~/.dotfiles/virtualenv-autoenv.sh
