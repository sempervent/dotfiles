#!/bin/bash
############
# install_dots.sh
# this script creates symlinks from the home directory to the dotfiles in ~/dotfiles
############

############ variables
dir=~/dotfiles
olddir=~/dotfiles_old
i3dir=~/.i3
files="vimrc bashrc tmux.conf gitconfig xinitrc Xresources Xdefaults"
i3files='i3config'
source $dir/colors.sh
############ work

# create dotfiles_old in homedir
echo -e "${NC}Creating ${LCYAN}${olddir}${NC} for backup of any existing dotfiles in ~"
mkdir -p ${olddir}
echo -e "\t\t\t\t\t...${GREEN}done\n"

# change to dotfiles dir
echo -e "${NC}Changing directory to ${LCYAN}${dir}${NC} directory"
cd ${dir}
echo -e "\t\t\t\t\t...${GREEN}done${NC}\n"

# move any existing dotfiles in homedir to dotfiles_old directory
# then create symlinks
for file in $files; do
   echo -e "Moving any existing ${LRED}${file}${NC} from ~ to $olddir"
   mv ~/.$file ~/dotfiles_old/
   echo -e "\tCreating symlink to ${GREEN}${file}${NC} in home directory.\n"
   ln -s $dir/$file ~/.$file
done

# move i3 files
echo -e "Changing to ${YELLOW}${i3dir}${NC}"
cd ${i3dir}
echo -e "Backing up i3config"
mv ~/.i3/config ~/.i3/config.back
echo -e "\tCreating symlink to ${GREEN}${i3files}${NC} in ${CYAN}${i3dir}${NC}.\n"
ln -s ~/dotfiles/i3config ~/.i3/config 
