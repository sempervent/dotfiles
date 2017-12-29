#!/bin/sh
# Send the header so that i3bar knows to use JSON:
echo '{"version":1}'
# Begin the endless array.
echo '['

# send an empty first array of blocks to make the loop simpler:
echo '[],'

# Now send blocks with information forever:
exec conky -c $HOME/dotfiles/conky/conkyi3status
