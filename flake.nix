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
    inputs@{ nixpkgs, unstable, ... }:
    {
      nixosConfigurations = builtins.mapAttrs (
        hostname: _:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/${hostname}
            (
              { pkgs, ... }:
              {
                _module.args.pkgsUnstable = import unstable { inherit (pkgs) system config; };
              }
            )
          ];
        }
      ) (nixpkgs.lib.filterAttrs (_: v: v == "directory") (builtins.readDir ./hosts));
    };
}
