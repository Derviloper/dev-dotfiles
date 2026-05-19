# Dotfiles

## VM Setup

```sh
sudo -i

parted "/dev/sda" --script mklabel gpt
parted "/dev/sda" --script mkpart ESP fat32 1MiB 512MiB
parted "/dev/sda" --script set 1 esp on
parted "/dev/sda" --script mkpart root ext4 512MiB 100%

mkfs.fat -F 32 -n boot "/dev/sda1"
mkfs.ext4 -F -L root "/dev/sda2"

mount /dev/disk/by-label/root /mnt
mkdir -p /mnt/boot
mount -o umask=077 /dev/disk/by-label/boot /mnt/boot

nixos-install --no-root-passwd --flake github:Derviloper/dev-dotfiles#desktop01

reboot
```
