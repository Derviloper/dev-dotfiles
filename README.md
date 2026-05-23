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
sudo nix --experimental-features 'nix-command flakes' run \
  github:nix-community/disko/latest -- \
  --mode destroy,format,mount \
  --flake github:Derviloper/dev-dotfiles#desktop01

sudo mkdir -p /mnt/var/lib/sops/age
sudo nano /mnt/var/lib/sops/age/keys.txt
sudo chmod 600 /mnt/var/lib/sops/age/keys.txt

sudo nixos-install --no-root-passwd \
  --flake github:Derviloper/dev-dotfiles#desktop01

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

## Secrets

Secrets are encrypted in-repo with [sops](https://github.com/getsops/sops) and
decrypted on-host by [sops-nix](https://github.com/Mic92/sops-nix). One personal
age keypair unlocks every VM.

### Adding or editing secrets

From any machine with the age key at `/var/lib/sops/age/keys.txt` (or
`~/.config/sops/age/keys.txt`):

```sh
sops secrets/secrets.yaml
```

Then declare the new entry under `sops.secrets.<name>` in
`modules/nixos/sops.nix` (set `owner`, `mode`, `path`), rebuild, commit, push.

## Formatting

```sh
nix fmt
```
