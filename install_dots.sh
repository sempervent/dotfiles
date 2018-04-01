#!/bin/bash
############
# install_dots.sh
# this script creates symlinks from the home directory to the dotfiles in ~/dotfiles
############

############ variables
dir=~/dotfiles
olddir=~/.dotfiles_old
i3dir=~/.i3
# configdir=~/.config
files="vimrc bashrc tmux.conf gitconfig xinitrc Xresources Xdefaults minttyrc"
i3files='i3config'
pwrlnconfig=~/.config/powerline
pwrln="tmux_powerline.conf"
# shellcheck source="$HOME/dotfiles/colors.sh"
source "$dir/colors.sh"
brand="Sempervent's dotfiles"

apts="i3wm tmux i3 i3blocks conky"
pips="powerline-status"

############ getopts
while getopts ":i" opt; do
   case $opt in
      i)
         if hash whiptail 2>/dev/null; then
            if [ "$(id -nu)" != "root" ]; then
               sudo -k
               pass=$(whiptail --backtitle "$brand Installer" --title "Authentication required" --passwordbox "Installing $brand requires software to properly use, and you passed the -i flag, so that's what this is going to do.\n\n[sudo] Password for user $USER:" 12 50 3>&2 2>&1 1>&3- )
               exec sudo apt-get install apt i3wm tmux i3 i3blocks conky
            fi
         else
            sudo apt-get install whiptail
         fi
         echo -e "-i was triggered. Install has finished?" >&2
         ;;
      \?)
         echo -e "Invalid option: -$OPTARG" >&2
   esac
done


#if [ $EUID != 0 ]; then
#   sudo "$0" "$@"
#   exit $?
#fi


############ work
# create dotfiles_old in homedir
echo -e "${NC}Creating ${LCYAN}${olddir}${NC} for backup of any existing dotfiles in ~"
mkdir -p ${olddir}
echo -e "\t\t\t\t\t...${GREEN}done\n"

# change to dotfiles dir
echo -e "${NC}Changing directory to ${LCYAN}${dir}${NC} directory"
cd ${dir} || exit
echo -e "\t\t\t\t\t...${GREEN}done${NC}\n"

# move any existing dotfiles in homedir to dotfiles_old directory
# then create symlinks
for file in $files; do
   echo -e "Moving any existing ${LRED}${file}${NC} from ~ to $olddir"
   mv "$HOME/.$file" ${olddir} 
   echo -e "\tCreating symlink to ${GREEN}${file}${NC} in home directory.\n"
   ln -s "$dir/$file" "$HOME/.$file"
done

# move i3 files
echo -e "Checking for ${CYAN}i3${NC} directory"
if [ -d "$i3dir" ];then
   echo -e "Changing to ${YELLOW}${i3dir}${NC}"
   cd ${i3dir} || exit
   echo -e "Backing up i3config"
   mv ~/.i3/config ~/.i3/config.back
   echo -e "\tCreating symlink to ${GREEN}${i3files}${NC} in ${CYAN}${i3dir}${NC}.\n"
   ln -s ~/dotfiles/i3config ~/.i3/config 
else
   echo -e "\t${RED}${i3dir}${NC} not found.\n"
fi

cd $dir || exit

# powerline config files
echo -e "Checking for ${CYAN}${pwrlnconfig}${NC} directory."
if [ -d "$pwrlnconfig" ];then
   echo -e "Found dir ${YELLOW}${pwrlnconfig}${NC}."
   echo -e "\tBacking up Powerline specific bindings"
   for conf in $pwrln; do
      echo -e "\tFound ${LRED}${conf}${NC} in ${CYAN}${pwrlnconfig}${NC}."
      mv $pwrlnconfig/${conf} ${olddir}/${conf}
      echo -e "\tCreating symlink to ${GREEN}${conf}${NC} in ${pwrlnconfig}."
      ln -s ${dir}/${conf} "${pwrlnconfig}/${conf}"
   done
else
   echo -e "\t\t\t\t${RED}${pwrlnconfig}{$NC} not found."
fi

echo -e "Installing ${LCYAN}Tmux Plugin Manager${NC}"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 

# report exit status
echo -e "\nYour ${GREEN}Dotfiles${NC} have been updated.\n"
