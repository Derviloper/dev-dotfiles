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

  outputs = { self, nixpkgs, unstable, home-manager, ... }:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./hardware-configuration.nix
          ./system

          home-manager.nixosModules.home-manager

          ({ config, pkgs, pkgsUnstable, ... }: {
            _module.args.pkgsUnstable = import unstable {
              inherit (pkgs.stdenv.hostPlatform) system;
              inherit (config.nixpkgs) config;
            };

            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit pkgsUnstable; };
              users.daniel-da-silva = import ./home;
              backupFileExtension = "hm-backup";
            };

            system.autoUpgrade = {
              enable = true;
              allowReboot = true;
              flake = self.outPath;
              flags = [
                "--update-input"
                "nixpkgs"
                "--no-write-lock-file"
              ];
            };
          })
        ];
      };
    };
}
