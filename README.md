# Dotfiles

NixOS + home-manager configuration, organised as a flake.

## Repo layout

- `flake.nix` — flake inputs and `nixosConfigurations` entry point.
- `hosts/<hostname>/` — host-specific config (hardware, vmware-guest, user, HM wiring).
- `modules/nixos/` — reusable NixOS modules grouped by feature.
- `modules/home-manager/` — reusable home-manager modules.
- `home/<user>.nix` — per-user home-manager entry point.

## VM Setup

Partitioning is declarative via [disko](https://github.com/nix-community/disko)
— layout lives in `hosts/desktop01/disko.nix`. From the NixOS installer:

```sh
sudo nix --experimental-features 'nix-command flakes' run \
  github:nix-community/disko/latest -- \
  --mode destroy,format,mount \
  --flake github:Derviloper/dev-dotfiles#desktop01

# Place the canonical SSH host keypair so sops-nix can decrypt at activation.
sudo install -d -m 755 /mnt/etc/ssh
sudo install -m 600 ssh_host_ed25519_key      /mnt/etc/ssh/ssh_host_ed25519_key
sudo install -m 644 ssh_host_ed25519_key.pub  /mnt/etc/ssh/ssh_host_ed25519_key.pub

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

Secrets live encrypted in `secrets/` via [sops](https://github.com/getsops/sops)

- [sops-nix](https://github.com/Mic92/sops-nix). The recipient is the host's
  own `/etc/ssh/ssh_host_ed25519_key` — sops-nix converts it to an age identity
  at activation.

`SOPS_AGE_KEY_CMD` is set system-wide (runs `ssh-to-age` against the host SSH
key):

```sh
sops secrets/secrets.yaml
```

Adding a secret:

1. `sops secrets/secrets.yaml` — add the key.
2. Declare it under `sops.secrets.<name>` in `modules/nixos/sops.nix` with
   `owner`, `mode`, `path`.
3. `sudo nixos-rebuild switch --flake .#desktop01`.

The age recipient in `.sops.yaml` is derived from the host's SSH pubkey:

```sh
ssh-to-age < /etc/ssh/ssh_host_ed25519_key.pub
```

## Formatting

```sh
nix fmt
```
