{ pkgs, pkgsUnstable, ... }: {
  imports = [
    ./shell.nix
    ./bspwm.nix
    ./polybar.nix
    ./picom.nix
    ./rofi.nix
    ./dunst.nix
  ];

  home.username = "daniel-da-silva";
  home.homeDirectory = "/home/daniel-da-silva";
  home.stateVersion = "25.11";

  home.packages = with pkgsUnstable; [
    ghostty
    brave
    vscode
    fzf
    rofi
    dunst
    polybar
    picom
    sxhkd
    libnotify
  ];

  programs.home-manager.enable = true;
}
