# ~.bashrc
# :set fdm=marker
# :set tw=79
# https://github.com/sempervent/dotfiles
################################################################################
# general Settings {{{1
# if not running interactively, don't do anything {{{2
case $- in
   *i*) ;;
      *) return;;
esac # 2}}}
# use powerline for PS1 {{{2
#powerline-daemon -q
#. /usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh
# 2}}}
# 1}}}
# History {{{1
###################
# don't put duplicate lines or lines starting with space in history
# see bash(1) for more options
HISTCONTROL=ignoreboth

# append to history file; don't overwrite it
shopt -s histappend

# set history length
HISTSIZE=100000
HISTFILESIZE=200000

# check the window after each command and update
# values of LINES and COLUMNS
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
# 1}}}
# Path {{{1
#-----------------------------------
export PATH=$PATH:/home/josh/scripts:$JAVA_HOME/bin
export EDITOR='vim'
export LD_LIBRARY_PATH=/usr/lib/R/lib:lib/usr/lib/x86_64-linux-gnu:/usr/lib/jvm/default-java/jre/lib/amd64/server:@JAVA_LD@
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk/jre/bin/java:/usr/bin/jvm/java-7-openjdk
export HADOOP_INSTALL=/usr/local/hadoop
export PATH=/usr/local/texlive/2016/bin/x86_64:$PATH
export PATH=$PATH:$HADOOP_INSTALL/bin
export PATH=$PATH:$HADOOP_INSTALL/sbin
export HADOOP_HOME=$HADOOP_INSTALL
export HADOOP_MAPRED_HOME=$HADOOP_INSTALL
export HADOOP_COMMON_HOME=$HADOOP_INSTALL
export HADOOP_HDFS_HOME=$HADOOP_INSTALL
export HADOOP_YARN_HOME=$HADOOP_INSTALL
export HADOOP_CONF_DIR=$HADOOP_INSTALL/etc/hadoop
# 1}}}
# Aesthetics {{{1
# set variable identifying the chroot you work in {{{2
# 2}}}
# set a fancy propmt (non-color, unless we know we "want" color) {{{2
case $XTERM in 
   xterm-color) color_prompt=yes;;
esac
# 2}}}
force_color_prompt=yes
# Colors {{{2
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
# 2}}}
# 1}}}

filenumber()
{
   /bin/ls -l | /usr/bin/wc -l | /bin/sed 's: ::g'
}

filesize()
{
   /bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //'
}

rightprompt()
{
   printf "%*s" $COLUMNS "$NCⁿ$RED\j $NCª$YELLOW\!"
   # printf "%*s" $COLUMNS "$NCヘ$YELLOW$(/bin/ls -l | /usr/bin/wc -l | /bin/sed 's: ::g')"
   # printf "%*s" $COLUMNS "$NC$YELLOW$(filenumber;)$NC▨$YELLOW$(filesize;)b"
}
#------------------------------------
# Greeting, motd, etc... {{{1
#------------------------------------
PS1="\n\[$(tput sc; rightprompt; tput rc)$NC┏┫$GREEN\]\u\[$NC\]@\[$BLUE\]\h\[$NC\]┣━━┫\[$BPURP\]\@\[$NC\]┣━━┫\[$CYAN\]\d\[$NC┣━━┫$YELLOW$(filenumber;)$NC⌂$YELLOW$(filesize;)b$NC┃\n┗━┫\[$YELLOW\]\w\[$NC\]┃ "
#------------------------------------
# Aliases {{{1
#------------------------------------
alias less='less --RAW-CONTROL-CHARS'
export LS_OPTS='--color=auto'
alias ls='ls ${LS_OPTS}'
# export GREP_OPTIONS='--color=auto'
alias grep='grep --color=auto'
alias stopcolors='sed "s/\[^[[0-9;]*[a-zA-Z]//gi"'
alias aptinstall='sudo aptitude install'
# alias bullshit="curl -s http://cbsg.sourceforge.net/cgi-bin/live | grep -Eo '<li>(.*?)</li>' | sed s,\</\?li\>,,g | shuf -n 1 | cowsay -f kosh"
alias bullshit="curl -s http://cbsg.sourceforge.net/cgi-bin/live | grep -Eo '<li>(.*?)</li>' | sed -e 's/<[^>]*>//g' | shuf -n 1 | cowsay -f kosh"
alias lstree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/' | less"
alias night="xrandr --output LVDS-1 --brightness 0.3"
alias dim="xbacklight -set 1"
alias bright="xbacklight -set 99"
alias dim="xbacklight -dec 10 -steps 50"
alias suspend="sudo systemctl suspend"
alias trello="chromium --app=https://trello.comn"
alias rstudio="chromium --app=http://192.168.1.178:8787"
alias google="chromium --app=https://google.com"
#------------------------------------
# Custom {{{1
#------------------------------------
#source ~/.bin/tmuxinator.bash
#------------------------------------
# Custom Commands {{{1
#------------------------------------
aptsearch () 
{
   # search and highlight keyword in the results
   export GREP_COLOR='1'
   # remove regexp patterns from the keyword to highlight
   keyword=`echo -n "$1" | sed -e 's/[^[:alnum:]|-]//g'`
   echo "Highlight keyword: $keyword"
   aptitude search "$1" --disable-columns | egrep --color "$keyword"

   # use the matching results to complete our install command
   matching=$(aptitude search --disable-columns -F "%p" "$1" | tr '\n' ' ')
   count=0
   for i in $matching ; do
      count=$((count + 1))
   done
   complete -W '$matching' aptinstall
   echo "(Matching packages: $count)"
   if ! [ -z $2 ] ; then
      echo -e "$matching" | egrep --color=always "$keyword"
   fi
}
markdown(){
   ~/scripts/Markdown_1.0.1/Markdown.pl $1 | lynx -stdin
}
#wal -R
