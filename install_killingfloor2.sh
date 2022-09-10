#!/bin/sh
#Install kf2 dedicated server
#Tyler Wight
#Change these these variables to configure what game to install.
#gamename: this vairable is used for the Linux user created and also the folder structure
#gamesteamcode: this is the code of the game you want to download
#installpath: This is the base directory to install the game to. It will add the gamename to the end, so in this example the full path will be /opt/valheim
#=====================
gamename=kf2
gamesteamcode=232130
installpath="/opt"
#=====================


fullpath="${installpath}/${gamename}"
cronjob="*/30 * * * * ${fullpath}/backup.sh"
sudo adduser $gamename
sudo usermod -aG sudo $gamename
sudo apt-get update -y && sudo apt-get upgrade -y

#adding multiverse required to install cmd on 64 bit machines

sudo add-apt-repository multiverse
sudo dpkg --add-architecture i386
sudo apt-get update -y
sudo apt install lib32gcc1 steamcmd -y
sudo ln -s /usr/games/steamcmd steamcmd
sudo mkdir -p $fullpath
sudo mkdir "${fullpath}/bak"

#if you write a backup script for your game you can have it copy the script to the install directory, and use the cronjob settings to make them automatic
#sudo cp -n ./backup.sh $fullpath/backup.sh

sudo chown -R $gamename:$gamename $fullpath
sudo su -c "steamcmd +login anonymous +force_install_dir ${fullpath} +app_update ${gamesteamcode} validate +exit" -s /bin/sh $gamename

#enable the below line to add the contents of the cronjob variable to the crontab of the user, this preserves all existing crontab entries
#sudo su -c "(crontab -l| grep -v -F '$cronjob'; echo '$cronjob') | crontab -" -s /bin/sh $gamename

#Replace default config files with included ones with correct maps and mutators

KFENGINE="${fullpath}/KFGame/Config/LinuxServer-KFEngine.ini"
KFGAME="${fullpath}/KFGame/Config/LinuxServer-KFGame.ini"

sudo su -c "cp LinuxServer-KFEngine.ini $KFENGINE" -s /bin/sh $gamename
sudo su -c "cp LinuxServer-KFGame.ini $KFGAME" -s /bin/sh $gamename
sudo su -c "cp ./*.sh ${fullpath}" -s /bin/sh $gamename
sudo rm -rf "${fullpath}/install_killingfloor2.sh"

if test -f "$KFENGINE"; then
	echo "${KFENGINE} exists"
else
	echo "can't find KFEngine.ini. Config didn't copy for some reason"
fi

if test -f "$KFGAME"; then
	echo "${KFGAME} exists"
else
        echo "can't find KFGame.ini. Config didn't copy for some reason"

fi

if test -f "${fullpath}/start_server.sh"; then
	echo "start_server.sh exists in path, copied correctly"

else
	echo "can't find start_server.sh. Scripts didn't copy for some reason"
fi


echo "The game ${gamename} has been installed or updated  via steamcmd."
echo "During the insallation we created a user named ${gamename} and installed the game to location ${fullpath}"
echo "The steam game code used to download from steam CMD was ${gamesteamcode}"
echo "You can run this script again to update the game."
