{
  description = "NixOS configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };
  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./hardware-configuration.nix

          ({ config, pkgs, ... }: {
            nix.settings.experimental-features = [ "nix-command" "flakes" ];

            boot.loader.grub = {
              enable = true;
              device = "/dev/sda";
              useOSProber = true;
            };

            nixpkgs.config.allowUnfree = true;

            networking = {
              hostName = "nixos";
              networkmanager.enable = true;

              firewall = {
                allowedTCPPorts = [
                  80
                  443
                  5173
                  5174
                  5175
                  5176
                ];
              };
            };

            time.timeZone = "Europe/Berlin";

            i18n = {
              defaultLocale = "en_US.UTF-8";
              extraLocaleSettings = {
                LC_ADDRESS = "de_DE.UTF-8";
                LC_IDENTIFICATION = "de_DE.UTF-8";
                LC_MEASUREMENT = "de_DE.UTF-8";
                LC_MONETARY = "de_DE.UTF-8";
                LC_NAME = "de_DE.UTF-8";
                LC_NUMERIC = "de_DE.UTF-8";
                LC_PAPER = "de_DE.UTF-8";
                LC_TELEPHONE = "de_DE.UTF-8";
                LC_TIME = "de_DE.UTF-8";
              };
            };

            console.keyMap = "de";

            services = {
              xserver = {
                enable = true;
                xkb = {
                  layout = "de";
                  variant = "us";
                };
                videoDrivers = [ "vmware" ];
              };
              desktopManager.gnome.enable = true;
              displayManager.gdm.enable = true;

              pulseaudio.enable = false;

              pipewire = {
                enable = true;
                alsa = {
                  enable = true;
                  support32Bit = true;
                };
                pulse.enable = true;
              };
            };

            security.rtkit.enable = true;

            users.users.daniel-da-silva = {
              isNormalUser = true;
              description = "Daniel da Silva";
              extraGroups = [ "networkmanager" "wheel" ];
            };

            fileSystems."/mnt/hgfs" = {
              device = ".host:/";
              fsType = "fuse./run/current-system/sw/bin/vmhgfs-fuse";
              options = ["umask=22" "uid=1000" "gid=100" "allow_other" "defaults" "auto_unmount"];
            };

            programs = {
              dconf.enable = true;
              fuse.enable = true;
              git.enable = true;
              nix-ld = {
                enable = true;
                libraries = with pkgs; [
                  xorg.libX11
                  libGL
                  gcc
                ];
              };
            };

            virtualisation.vmware.guest.enable = true;

            fonts.packages = with pkgs; [
              nerd-fonts.meslo-lg
            ];

            environment = {
              systemPackages = with pkgs; [
                fzf
                zsh-powerlevel10k
                ghostty

                brave

                vscode

                gcc

                (symlinkJoin {
                  name = "python311";
                  paths = [ python311 ];
                  buildInputs = [ pkgs.makeWrapper ];
                  postBuild = ''
                    wrapProgram "$out/bin/python3.11" \
                      --run 'export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH'
                  '';
                })

                (symlinkJoin {
                  name = "cargo";
                  paths = [ cargo ];
                  buildInputs = [ pkgs.makeWrapper ];
                  postBuild = ''
                    wrapProgram "$out/bin/cargo" \
                      --run 'export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH'
                  '';
                })
                rustc
                rustfmt
                clippy
                rust-analyzer
                rust.packages.stable.rustPlatform.rustLibSrc
              ];

              variables = {
                RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
              };

              etc."p10k.zsh".source = ./p10k.zsh;
            };

            programs.zsh = {
              enable = true;
              autosuggestions.enable = true;
              syntaxHighlighting.enable = true;
              interactiveShellInit = ''
                source ${pkgs.fzf}/share/fzf/key-bindings.zsh
                source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
                if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
                  source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
                fi
                source /etc/p10k.zsh
              '';
            };

            users.defaultUserShell = pkgs.zsh;

            xdg.mime.defaultApplications = {
              "text/html" = "brave-browser.desktop";
              "x-scheme-handler/http" = "brave-browser.desktop";
              "x-scheme-handler/https" = "brave-browser.desktop";
              "x-scheme-handler/about" = "brave-browser.desktop";
              "x-scheme-handler/unknown" = "brave-browser.desktop";
            };

            system.stateVersion = "25.11";
          })
        ];
      };
    };
}
