{ pkgs, ... }:
{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs.unstable; [
      stdenv.cc.cc
    ];
  };
}
