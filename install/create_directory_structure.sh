#!/bin/bash

# if code needs to go here if the directory structure exists, skip all this
cd 
mkdir .vim
cd .vim
mkdir bundle
cd bundle

git clone https://github.com/VunldeVim/Vundle.vim
