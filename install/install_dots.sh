#!/bin/env bash
############
# install_dots.sh
# this script creates symlinks from the dotfiles directory to the specified
# symlink location in ./resources/manifest.csv. Any location change should
# be updated there.
# read relevant resources {{{1
# check existence of manifest.csv {{{2
if [ -e ~/dotfiles/resources/manifest.csv ]
then
   echo -e "using resources/manifest.csv"
else
   stop "resources/manifest.csv not found"
fi
# 2}}}
# populate files and where they should symlink {{{2
dots=()
syms=()
while read -r type group dotfile symlink; do
   dots+=("$type/$group/$dotfile")
   syms+=("$symlink" )
done < <(sed 's/,/\t/g' ~/dotfiles/resources/manifest.csv)
# check for existence of files {{{3 
for i in "${dots[@]}"; do
   if [ -e "$i" ]; then
      printf 'element %s not found' "$i"
   fi
done
# 3}}}
# 2}}}
# 1}}}
# 1}}}
# getopts {{{1
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
# 1}}}
# sudo check {{{1
# uncomment below to only run if sudo
#if [ $EUID != 0 ]; then
#   sudo "$0" "$@"
#   exit $?
#fi
# 1}}}
# setup directory structures {{{1
# create dotfiles_old in homedir
echo -e "${NC}Creating ${LCYAN}${olddir}${NC} for backup of any existing dotfiles in ~"
mkdir -p ${olddir}
echo -e "\t\t\t\t\t...${GREEN}done\n"
# create directory structure for vim undo
mkdir ~/.vim/undo
# create the scripts directory
mkdir ~/.scripts
# 1}}}
# syncronize files {{{1
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
# 1}}}
# move i3 files {{{1
echo -e "Checking for ${CYAN}i3${NC} directory"
if [ -d "$i3dir" ];then
   echo -e "Changing to ${YELLOW}${i3dir}${NC}"
   cd ${i3dir} || exit
   echo -e "Backing up i3config"
   mv ~/config/i3/config ~/.config/i3/config.back
   echo -e "\tCreating symlink to ${GREEN}${i3files}${NC} in ${CYAN}${i3dir}${NC}.\n"
   ln -s ~/dotfiles/i3config ~/.config/i3/config 
else
   echo -e "\t${RED}${i3dir}${NC} not found.\n"
fi
cd $dir || exit
# 1}}}
# powerline config files {{{1
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
# 1}}}
# setup tmux plugin manager {{{1
echo -e "Installing ${LCYAN}Tmux Plugin Manager${NC}"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 
# 1}}}
# exit {{{1
# report exit status
echo -e "\nYour ${GREEN}Dotfiles${NC} have been updated.\n"
>>>>>>> 4b812f7ec731497b42042a4b7e72c8b0987d9139
# 1}}}
