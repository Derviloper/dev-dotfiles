{ pkgs, ... }:
{
  home.packages = with pkgs.unstable; [
    brave
    btop
    vscode
  ];
}
