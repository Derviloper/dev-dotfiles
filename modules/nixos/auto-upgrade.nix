{ inputs, ... }:
{
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "--no-write-lock-file"
    ];
  };
}
