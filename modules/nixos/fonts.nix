{ pkgs, ... }:
{
  fonts.packages = with pkgs.unstable; [
    nerd-fonts.meslo-lg
    roboto
  ];
}
