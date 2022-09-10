# Install Killing Floor 2

This script will install killing floor 2 on a Linux Serer. All my testing was done on ubuntu 20.04

This script automatically includes about 6-7 maps we often play, and includes the mutators to play the game with a 16 player limit (instead of 6). This do not have to be used and are just part of the config files.

You can start the game normally without 16 player limit with the start_server_normal.sh 

For whatever reason when using 16 player mutators whenever it changes map it removes the 16 player limit causing me to close and restart the server for every map change. So the scripts with the names are used to easily open specific maps after shutting the game down, to perserve teh 16 player limit. Annoying but this was the only way I could figure out how to handle it


# how to use

1. clone this repo
2. run the install_killingfloor2.sh file from a user that has sudo privledges
3. go to the /opt/kf2 as the kf2 user and run the script you'd like. May need to run once to download all the levels/mutators and try again
4. To update kf2 server just run the .sh again
