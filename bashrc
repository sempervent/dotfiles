# if not running interactively, don't do anything
case $- in
   *i*) ;;
      *) return;;
esac

###################
# History {{{1
###################
# don't put duplicate lines or lines starting with space in history
# see bash(1) for more options
HISTCONTROL=ignoreboth

# append to history file; don't overwrite it
shopt -s histappend

# set history length
HISTSIZE=1000
HISTFILESIZE=2000

# check the window after each command and update
# values of LINES and COLUMNS
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in
if [ -z ${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
   debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy propmt (non-color, unless we know we "want" color)
case $XTERM in 
   xterm-color) color_prompt=yes;;
esac

force_color_prompt=yes
RESET="\[\033[0m\]"
RED="\[\033[0;31m\]"
GREEN="\[\033[01;32m\]"
BLUE="\[\033[01;34m\]"
YELLOW="\[\033[0;33m\]"
PS1="\[\[\033[0;37m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\334\227\[\033[0;37m\]]\342\224\200\")[$(if [[${EUID} == 0]]; then echo '\[\033[0;31m\]\h; else echo '\[\033[0;33m\]\u\[\033[0;37m\]@\[\033[0;96m\]h'; fi)\[\033[0;37m\]]\342\224\200[\[\033[0;37m\]]\342\224\200\[\[\\033[0;34m\]\@\[\033[0;37m\]\342\224\224\342\224\200[\[\033[0;32m\]\2\[\033[0;37m\]]\342\224\200\342\225\274 $RS"fi#"# 1}}}
