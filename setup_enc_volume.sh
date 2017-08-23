sudo apt-get -y install cryptsetup
sudo dd if=/dev/urandom of=/root/tinfoil bs=1M count=256
sudo cryptsetup -y -h sha256 luksFormat /root/tinfoil
sudo cryptsetup luksOpen /root/tinfoil tinfoil
sudo mkfs.ext4 -j /dev/mapper/
sudo mkdir /mnt/tinfoil
sudo mount /dev/mapper/tinfoil /mnt/tinfoil
sudo umount /mnt/tinfoil
sudo cryptsetup luksClose tinfoil
