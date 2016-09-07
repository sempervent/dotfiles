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

# Do Prompt Stuff {{{1
# set variable identifying the chroot you work in

# set a fancy propmt (non-color, unless we know we "want" color)
case $XTERM in 
   xterm-color) color_prompt=yes;;
esac


force_color_prompt=yes

# Colors {{{1
# Normal Colors
BLACK='\e[0;30m'
RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[0;33m'
BLUE='\e[0;34m'
PURPLE='\e[0;35m'
CYAN='\e[0;36m'
WHITE='\e[0;37m'
BPURP='\e[1;34m'
NC="\e[m"

#------------------------------------
# Greeting, motd, etc... {{{1
#------------------------------------


PS1="\n\[$NC\[\016\[l\[\017\][$GREEN\]\u\[$NC\]@\[$BLUE\]\h\[$NC\]]━[\[$RED\]\j\[$NC\]]━[\[$BPURP\]\@\[$NC\]]━[\[$CYAN\]\d\[$NC]\[\n\]\[\016\]\]\[m\]\[\017\]━[\[$YELLOW\]\w\[$NC\]]━\\[$ \]"
# Aliases {{{1
alias less='less --RAW-CONTROL-CHARS'
export LS_OPTS='--color=auto'
alias ls='ls ${LS_OPTS}'
export GREP_OPTIONS='--color=auto'
alias stopcolors='sed "s/\[^[[0-9;]*[a-zA-Z]//gi"'

