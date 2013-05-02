#!/usr/bin/env bash

# find whether emasc is installed
EMACS_PATH=`which emacs`

if ! [[ -z $EMACS_PATH ]]; then
    # if installed, check whether the daemon is started
    pid=`ps ux | grep 'emacs.*daemon' | grep -v 'grep' | cut -d ' ' -f 2`
    if [[ -z $pid ]]; then
	# if not, start the daemon process
	emacs --daemon &> /dev/null
    fi
fi
