#!/bin/bash
############
# install_dots.sh
# this script creates symlinks from the home directory to the dotfiles in ~/dotfiles
############

############ variables
dir=~/dotfiles
olddir=~/dotfiles_old
files="vimrc bashrc tmux.conf"

############ work

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to dotfiles dir
echo "Changing directory to $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory
# then create symlinks
for file in $files; do
   echo "Moving any existing dotfiles from ~ to $olddir"
   mv ~/.$file ~/dotfiles_old/
   echo "Creating symlink to $file in home directory."
   ln -s $dir/$file ~/.$file
done

