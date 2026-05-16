{ config, pkgs, pkgsUnstable, ... }: {
  imports = [
    ./desktop.nix
  ];

  nixpkgs.config.allowUnfree = true;

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;

    firewall.allowedTCPPorts = [
      22
      80
      443
      5173
      5174
      5175
      5176
    ];
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
      videoDrivers = [ "modesetting" ];
    };

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "no";
      };
    };

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
    options = [ "umask=22" "uid=1000" "gid=100" "allow_other" "defaults" "auto_unmount" ];
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
    zsh.enable = true;
  };

  virtualisation.vmware.guest.enable = true;

  environment = {
    systemPackages = with pkgsUnstable; [
      btop
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
      RUST_SRC_PATH = "${pkgsUnstable.rust.packages.stable.rustPlatform.rustLibSrc}";
    };
  };

  users.defaultUserShell = pkgsUnstable.zsh;

  xdg.mime.defaultApplications = {
    "text/html" = "brave-browser.desktop";
    "x-scheme-handler/http" = "brave-browser.desktop";
    "x-scheme-handler/https" = "brave-browser.desktop";
    "x-scheme-handler/about" = "brave-browser.desktop";
    "x-scheme-handler/unknown" = "brave-browser.desktop";
  };

  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };

    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  system.stateVersion = "25.11";
}
