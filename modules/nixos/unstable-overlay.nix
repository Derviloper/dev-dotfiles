{ inputs, config, ... }:
{
  nixpkgs.overlays = [
    (final: _: {
      unstable = import inputs.unstable {
        inherit (final.stdenv.hostPlatform) system;
        inherit (config.nixpkgs) config;
      };
    })
  ];
}
