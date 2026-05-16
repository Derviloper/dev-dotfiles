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
          specialArgs = { inherit inputs hostname; };
          modules = [
            ./hosts/${hostname}
            (
              { pkgs, config, ... }:
              {
                _module.args.pkgsUnstable = import unstable {
                  inherit (pkgs.stdenv.hostPlatform) system;
                  inherit (config.nixpkgs) config;
                };
              }
            )
          ];
        }
      ) (nixpkgs.lib.filterAttrs (_: v: v == "directory") (builtins.readDir ./hosts));
    };
}
