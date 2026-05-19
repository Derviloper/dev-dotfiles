{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ nixpkgs, ... }:
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;

      nixosConfigurations = builtins.mapAttrs (
        hostname: _:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs hostname; };
          modules = [ ./hosts/${hostname} ];
        }
      ) (nixpkgs.lib.filterAttrs (_: v: v == "directory") (builtins.readDir ./hosts));
    };
}
