{ ... }:

{
  imports = [
    ./boot.nix
    ./networking.nix
    ./locale.nix
    ./audio.nix
    ./hyprland.nix
    ./fonts.nix
    ./vm.nix
    ./nix.nix
    ./programs.nix
    ./packages.nix
    ./xdg.nix
    ./users.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
