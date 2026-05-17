# Dotfiles

## VM Setup
1. Boot into the NixOS live ISO
2. Create a ext4 partition with the label `root` and the flag `boot`
3. Mount the partition under /mnt (`sudo mount /dev/disk/by-label/root /mnt`)
4. Install NixOS (`sudo nixos-install --no-root-passwd --flake github:Derviloper/dev-dotfiles#desktop01`)
