# Dotfiles

NixOS + home-manager configuration, organised as a flake.

## Repo layout

- `flake.nix` — flake inputs and `nixosConfigurations` entry point.
- `hosts/<hostname>/` — host-specific config (hardware, vmware-guest, user, HM wiring).
- `modules/nixos/` — reusable NixOS modules grouped by feature.
- `modules/home-manager/` — reusable home-manager modules.
- `home/<user>.nix` — per-user home-manager entry point.

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

## Rebuilding

```sh
sudo nixos-rebuild switch --flake .#desktop01
```

## Updating inputs

```sh
nix flake update
git commit flake.lock -m "flake: update inputs"
sudo nixos-rebuild switch --flake .#desktop01
```

## Adding a host

1. Create `hosts/<newname>/` with `default.nix` and `hardware.nix` (run
   `nixos-generate-config --dir hosts/<newname>` to populate hardware).
2. The flake picks it up automatically (`builtins.readDir ./hosts`).
3. Build with `sudo nixos-rebuild switch --flake .#<newname>`.

## Forwarding dev-server ports

The firewall only exposes 22/80/443. To reach a Vite/etc. dev server from the
host machine, use SSH local forwarding:

```sh
ssh -L 5173:localhost:5173 derviloper@<vm-ip>
```

Then open `http://localhost:5173` on the host. Add more `-L PORT:localhost:PORT`
flags for additional ports.

## Formatting

```sh
nix fmt
```
