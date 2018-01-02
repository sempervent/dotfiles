#!/bin/bash

# script only works with sudo unless you have write in /opt

# create directory in /opt/ 
cd /opt/ || exit
mkdir suckless && cd suckless || exit
git clone http://git.suckless.org/st
cd st || exit

curl https://st.suckless.org/patches/scrollback/st-scrollback-20170329-149c0d3.diff | git apply
curl https://st.suckless.org/patches/scrollback/st-scrollback-mouse-20170427-5a10aca.diff | git apply
curl https://st.suckless.org/patches/scrollback/st-scrollback-mouse-altscreen-20170427-5a10aca.diff | git apply
# note: an X composite manager such as compton is needed for the below patch
#curl https://st.suckless.org/patches/alpha/st-alpha-20170509-5a10aca.diff | git apply

