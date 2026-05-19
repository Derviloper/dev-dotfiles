# Dotfiles

## VM Setup
1. Boot into the NixOS live ISO
2. If not already done: Create `gpt` patition table
3. Create a ext4 partition with the label `root` and the flag `boot`
4. Mount the partition under /mnt (`sudo mount /dev/disk/by-label/root /mnt`)
5. Install NixOS (`sudo nixos-install --no-root-passwd --flake github:Derviloper/dev-dotfiles#desktop01`)
