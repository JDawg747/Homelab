#!/bin/bash 

# Purpose: Configure Kali Linux VM 
# Last Updated: 15/September/2022

sudo apt update && sudo apt upgrade -y 
sudo apt install git
sudo apt install kali-desktop-kde -y
sudo apt -y install powershell
sudo apt install gobuster
sudo apt install net-tools
cd /home/jdawg747/
git clone https://github.com/danielmiessler/SecLists.git

# sudo apt install kali-desktop-gnome -y
# sudo apt install kali-desktop-kde -y
# VS Code: https://code.visualstudio.com/docs/setup/linux       sudo apt install ./c*.deb