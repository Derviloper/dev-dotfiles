{ pkgs, ... }:

{
  programs = {
    dconf.enable = true;
    fuse.userAllowOther = true;
    git.enable = true;
    zsh.enable = true;

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        xorg.libX11
        libGL
        gcc
      ];
    };
  };
}
