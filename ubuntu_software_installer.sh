#!/bin/bash
# run it as sudo yes | sh ubuntu_software_installer.sh
# Put autoDownload folder under your home path
#
## Note for ROS installation 
# Configure your Ubuntu repositories to allow "restricted," "universe," and "multiverse." 
# You can follow the Ubuntu guide for instructions on doing this. 
#
# TODO: 
#       - maintain personal install bash on github, so that on the local bash file we only need one 
#         command line using wget. like-> http://wiki.ros.org/ROS/Installation/TwoLineInstall/
#       - optional application in terminal to choose


## Set variable for this bash file
mkdir -p deb_autoDownload

parentfolder=autoDownload
debfolder=deb_autoDownload

## define functions
divider(){
    echo ""
    echo "#######################################################################################################################"
    echo "###############################################INSTALLING $1####################################################"
    echo "#######################################################################################################################"
}

# mkdir -p ~/$parentfolder/deb

## INSTALL
sudo apt update && sudo apte upgrade
# wget
sudo apt install wget 
# terminator
sudo apt install terminator -y
# tree
sudo apt install tree
# git
sudo apt-get install git -y ## if not installed
sudo add-apt-repository -y ppa:git-core/ppa
sudo apt-get update
sudo apt-get install git -y ## if already installed, just update
# git-lfs
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo apt-get install git-lfs

divider "nmap"      && sudo apt install nmap -y      # network scan tool
divider "wipe"      && sudo apt install wipe -y      # delete file permanently, -r: recursion, -f: force delete, -i: display info
divider "net-tools" && sudo apt install net-tools    # net tools
divider "systemd"   && sudo apt install systemd      # install systemctl package
divider "jq"        && sudo apt install jq           # tool for parsing and manipulating JSON data in Linux

#while read url; do
#    wget $url
#done < urls.txt



## necessary softwares 

# VS code
# Reference: https://code.visualstudio.com/docs/setup/linux
divider "VS CODE"
wget https://go.microsoft.com/fwlink/?LinkID=760868 -O ./$debfolder/code_1.80.0-1688479026_amd64.deb
sudo apt install ./$debfolder/code_1.80.0-1688479026_amd64.deb
sudo apt install apt-transport-https
sudo apt install code # or code-insiders
sudo rm ./$debfolder/code_1.80.0-1688479026_amd64.deb
# todo vscode plugin auto from cloud sync

divider "Wireshark" && sudo apt install wireshark -y # network analyse tool

## optional softwares

sudo snap install vlc
# EDGE
divider "EDGE"
#wget https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
#sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
#sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
#sudo rm microsoft.gpg
#sudo apt-get update && sudo apt install microsoft-edge-stable 
# reference: https://chrisjean.com/fix-apt-get-update-the-following-signatures-couldnt-be-verified-because-the-public-key-is-not-available/
# if GPG error is showing: The following signatures couldn't be verified because the public key is not available: <xxxxxx>
# using sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys <xxxxxx> to solve the problem 

# https://askubuntu.com/questions/1454325/unable-to-install-edge-on-ubuntu-22-04
wget https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_110.0.1587.41-1_amd64.deb?brand=M102
mv microsoft-edge-stable_110.0.1587.41-1_amd64.deb?brand=M102 microsoft-edge-stable_110.0.1587.41-1_amd64.deb # rename
sudo apt install ./microsoft-edge-stable_110.0.1587.41-1_amd64.deb

# PCAN-view
# Reference: https://www.peak-system.com/fileadmin/media/linux/index.htm
divider "PCAN-View"
wget -q http://www.peak-system.com/debian/dists/`lsb_release -cs`/peak-system.list -O- | sudo tee /etc/apt/sources.list.d/peak-system.list # install the file peak-system.list from the PEAK-System website
wget -q http://www.peak-system.com/debian/peak-system-public-key.asc -O- | sudo apt-key add - # download and install the PEAK-System public key for apt-secure, so that the repository is trusted
sudo apt-get install pcanview-ncurses


divider "keepass2"  && sudo apt install keepass2 -y     # passwort management
                      wget https://raw.github.com/pfn/keepasshttp/master/KeePassHttp.plgx # download plugin KeePassHttp
                                                                                          # Reference: https://github.com/RoelVB/ChromeKeePass
                      sudo  mv KeePassHttp.plgx /usr/lib/keepass2
                      sudo apt-get install mono-mcs # added dependencies for KeePassHttp 
                                                    # Reference: https://github.com/pfn/keepasshttp/issues/242, https://github.com/kee-org/KeeFox/issues/148
                                                    
divider "keepassxc" && sudo snap install keepassxc -y 
sudo snap connect "keepassxc:raw-usb" "core:raw-usb" # Due to a Snap's isolation and security settings, must manually enable the raw-usb interface in order to use YubiKey. 

## ROS
# Reference: http://wiki.ros.org/noetic/Installation/Ubuntu
divider "ROS"
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt install curl -y # if you haven't already installed curl
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo apt update && sudo apt install ros-noetic-desktop-full -y
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
source ~/.bashrc
sudo apt install python3-catkin-tools python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential 
sudo rosdep init
rosdep update

# TAS-related debian packages


# catkin_tools

# ROS-related debian packages
sudo apt install ros-$ROS_DISTRO-plotjuggler-ros


## GIT config
#git config --global user.email "stefan.novakovich@gmail.com"
#git config --global user.name "snovakovic"

echo -----------------------------------------------------------------------------------------------------
echo -------------------------------Auto Installing Programs FINISHED-------------------------------------
echo -----------------------------------------------------------------------------------------------------

