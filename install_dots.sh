#!/bin/bash
############
# install_dots.sh
# this script creates symlinks from the home directory to the dotfiles in ~/dotfiles
############

############ variables
dir=~/dotfiles
olddir=~/dotfiles_old
files="vimrc bashrc tmux.conf gitconfig"
source colors.sh
############ work

# create dotfiles_old in homedir
echo -e "${NC} Creating ${LCYAN}${olddir}${NC} for backup of any existing dotfiles in ~"
mkdir -p ${olddir}
echo -e "...${GREEN}done\n"

# change to dotfiles dir
echo -e "${NC}Changing directory to ${LCYAN}${dir}${NC} directory"
cd ${dir}
echo -e "...${GREEN}done${NC}\n"

# move any existing dotfiles in homedir to dotfiles_old directory
# then create symlinks
for file in $files; do
   echo -e "Moving any existing ${LRED}${file}${NC} from ~ to $olddir"
   mv ~/.$file ~/dotfiles_old/
   echo -e "\tCreating symlink to ${GREEN}${file}${NC} in home directory.\n"
   ln -s $dir/$file ~/.$file
done


