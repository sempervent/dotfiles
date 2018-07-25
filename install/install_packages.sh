#!/bin/bash

FILE="/tmp/out.$$"
GREP="/bin/grep"

# must be run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root." 1>&2
   exit 1
fi

PACKAGES="mothur powerline perl python2.7 python-apt python-biopython python-dev python-matplotlib python-numpy python-pip python-scipy r-base lynx vim sudo git vim vim-addon-manager vim-common cim-syntastic vim-ultisnips tmux"

apt-get install $PACKAGES
