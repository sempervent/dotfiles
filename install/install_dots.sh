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
# exit {{{1
# report exit status
echo -e "\\nYour ${GREEN}Dotfiles${NC} have been updated.\\n"
# 1}}}
