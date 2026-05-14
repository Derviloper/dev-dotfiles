{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wl-clipboard
    cliphist
    grim
    slurp
    swappy

    brightnessctl
    playerctl

    pavucontrol
    pwvucontrol

    networkmanagerapplet

    nautilus

    hyprpolkitagent

    xdg-utils
  ];
}
