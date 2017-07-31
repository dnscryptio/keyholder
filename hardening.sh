#!/bin/bash

# Update packages
sudo apt-get update
sudo apt-get -y upgrade

# Add new users
sudo useradd egon -s /bin/bash -m -G adm,sudo
sudo useradd simon -s /bin/bash -m -G adm,sudo

# Let them sudo passwordless
sudo echo "egon ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/egon
sudo echo "simon ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/simon

# And add their keys
sudo mkdir /home/egon/.ssh/
sudo mkdir /home/simon/.ssh/
sudo chmod 0700 /home/egon/.ssh/
sudo chmod 0700 /home/simon/.ssh/
sudo echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDOQ7PNf73W/SlbtsONHFESlDoWWug9qqXoD0r3CZNAe1mWaLocCh9xNv1wI80hTjGqTDDB49wgLYrVzRtMVzF9CZ3WtoCGeMBx9niWvH6qcoAgUd8LFjmzFSOeCFJoFjx1FLO/o+93mnOWZd12C67Bfg91gcvw66WVgUGqeJMOBAkP7cEV7ZJToZcWZy1x3+KgJyJclqCMMA3zp73UPbE63851vCC1TPyWZhaW4HiThlh9mdNp36ut2ewo86DaYnu5v2Gx6NSNnIykpJD2yUEtMnBqoRjVf+7HeaoL7ZrVMaOpKJ0b5f5Kxk+0rXB7lI73F0J9RaR5abRGiDqZUNJR kidmose@client" >> /home/egon/.ssh/authorized_keys
sudo echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDf10JOCaGYdFJ7yjDzyYnTUWbg1ytbnQpZq3pcR+ZnUO5Wb4Im1op0ecjOdDw/Qa1Y4LZDvzw5J7j25cQuAl88YxILfv2qxPsDsnv1vWLFsMCyCumn6cnOLB5qbFByiuOHp3J8Ug66ZEsSVZWGHSOk/SdCJPzlCgVsJrDDOjJe8PGNrH8mFnyTg6W7CYzBnTxUyu5gejx4+P8fDtLHs2frCQ9eNk3SJvBbB9MgFrCNCdLqBPeL+XB5+qiR7iNgVzZiYsHIXrRpOF4GKzdDAdu3VHEEwHCdvYbkdLTEfDfhlCaw9jD8vyU0Q4ZQYu6/RfweYCLryo+GRDbAMTZ+dUzD simon@client" >> /home/simon/.ssh/authorized_keys

# Delete pi user
sudo userdel -rf pi
sudo rm /etc/sudoers.d/010_pi-nopasswd

# Lower allocation to GPU
echo "gpu_mem=16" | sudo tee -a /boot/config.txt

# Change hostname
sudo sed -i 's/raspberrypi/tinfoil/g' /etc/hosts
sudo sed -i 's/raspberrypi/tinfoil/g' /etc/hostname

# Diable uneeded services
sudo systemctl disable avahi-daemon.service
sudo systemctl disable bluetooth.service
sudo systemctl disable bus-org.bluez.service
sudo systemctl disable dbus-org.freedesktop.Avahi.service


# SSH
echo "PasswordAuthentication no" | sudo tee -a /etc/ssh/sshd_config
sudo sed -i -e 's/PermitRootLogin.*/PermitRootLogin no/' '/etc/ssh/sshd_config'

# Configure unattended-upgrades
sudo apt-get -y install unattended-upgrades
sudo dpkg-reconfigure -plow unattended-upgrades
