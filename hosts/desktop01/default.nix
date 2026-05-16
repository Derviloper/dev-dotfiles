{
  inputs,
  pkgs,
  pkgsUnstable,
  hostname,
  ...
}:
let
  username = "derviloper";
in
{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  networking = {
    hostName = hostname;
    nftables.enable = true;
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

  security.sudo.wheelNeedsPassword = false;

  fonts.packages = with pkgs; [ nerd-fonts.meslo-lg ];

  services.xserver = {
    enable = true;
    windowManager.bspwm.enable = true;
    displayManager.lightdm = {
      enable = true;
      greeters.gtk.enable = true;
    };
    desktopManager.runXdgAutostartIfNone = false;
    xkb = {
      layout = "de";
      variant = "us";
    };
    videoDrivers = [ "modesetting" ];
  };

  virtualisation.vmware.guest.enable = true;

  environment = {
    systemPackages = with pkgsUnstable; [
      brave
      btop
      fzf
      ghostty
      nixfmt
      vscode
      zsh
      zsh-powerlevel10k
    ];

    etc."p10k.zsh".source = ./p10k.zsh;
  };

  programs = {
    git.enable = true;
    ssh.startAgent = true;
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      interactiveShellInit = ''
        source ${pkgsUnstable.fzf}/share/fzf/key-bindings.zsh
        source ${pkgsUnstable.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
        source /etc/p10k.zsh
      '';
    };
  };
  users.defaultUserShell = pkgsUnstable.zsh;
  home-manager.sharedModules = [ { home.file.".zshrc".text = ""; } ];

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs pkgsUnstable username; };
    users.${username} = ./home.nix;
  };

  nixpkgs.config.allowUnfree = true;
  boot.loader.grub = {
    device = "/dev/sda";
    useOSProber = true;
  };
  system = {
    autoUpgrade = {
      enable = true;
      allowReboot = true;
      flake = inputs.self.outPath;
      flags = [
        "--update-input"
        "nixpkgs"
        "--no-write-lock-file"
      ];
    };
    stateVersion = "25.11";
  };
}
