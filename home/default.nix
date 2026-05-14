{ ... }:

{
  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./wofi.nix
    ./mako.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./hyprpaper.nix
    ./ghostty.nix
    ./zsh.nix
    ./git.nix
    ./packages.nix
    ./vscode.nix
  ];

  home.username = "daniel-da-silva";
  home.homeDirectory = "/home/daniel-da-silva";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
