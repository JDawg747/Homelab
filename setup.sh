#!/bin/bash 

# Purpose: Configure Ubuntu Server 
# Last Updated: 15/September/2022

# Remember to also update the hostname in the /etc/hosts file
sudo hostnamectl set-hostname joshlab

sudo apt update && sudo apt upgrade -y 
sudo apt install unattended-upgrades -y 
dpkg-reconfigure --priority=low unattended-upgrades 

sudo apt-get install openssh-server -y
cd /home/$USER/Homelab
sudo cp ./sshd_config /etc/ssh
sudo systemctl enable ssh
sudo systemctl start ssh

cd /home/$USER/Homelab
sudo cp ./01-netcfg.yaml /etc/netplan
sudo netplan apply

# LVM Partitioning (Ubuntu Only)
sudo lvm
lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv
exit
sudo resize2fs /dev/ubuntu-vg/ubuntu-lv

# Timezone and NTP 
sudo timedatectl set-timezone America/New_York
sudo timedatectl set-ntp off
cd /home/$USER/Homelab
sudo cp ./timesyncd.conf /etc/systemd/timesyncd.conf
sudo timedatectl set-ntp on

sudo apt install net-tools