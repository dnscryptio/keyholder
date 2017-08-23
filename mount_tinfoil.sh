#!/bin/bash
sudo cryptsetup luksOpen /root/tinfoil tinfoil
sudo mount /dev/mapper/tinfoil /mnt/tinfoil
