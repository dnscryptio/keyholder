# Introduction
This repo contains notes and script for setting up and using the keyholder box.

This is currently based on a Raspberry Pi.

# Initial setup
Log in to the newly installed pi (or write to the mounted SD card):

1. Enable ssh: `sudo touch /boot/ssh`
1. Reboot

Connect via SSH with default credentials

1. Run: `hardening.sh`
1. Run: `install_wrapper.sh`
1. Run: `setup_enc_volume.sh`
1. (install service key functionality)

# Using encrypted volume

* Mount: `./mount_tinfoil.sh`
* Unmount: `./umont_tinfoil.sh`
