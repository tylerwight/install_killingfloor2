#!/bin/sh
#Install kf2 dedicated server
#Tyler Wight

sudo adduser kf2
sudo usermod -aG sudo kf2
sudo apt-get update -y && sudo apt-get upgrade -y

#adding multiverse required to install cmd on 64 bit machines

sudo add-apt-repository multiverse
sudo dpkg --add-architecture i386
sudo apt-get update -y
sudo apt install lib32gcc1 steamcmd -y
sudo ln -s /usr/games/steamcmd steamcmd
sudo mkdir /mnt/kf2
sudo chown -R kf2:kf2 /mnt/kf2
sudo chmod 764 /mnt/kf2
sudo su -c "steamcmd +login anonymous +force_install_dir /mnt/kf2 +app_update 232130 validate +exit" -s /bin/sh root


