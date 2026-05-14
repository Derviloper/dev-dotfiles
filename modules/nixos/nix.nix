{ self, ... }:

{
  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };

    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  system = {
    autoUpgrade = {
      enable = true;
      allowReboot = true;
      flake = self.outPath;
      flags = [
        "--update-input"
        "nixpkgs"
        "--no-write-lock-file"
      ];
    };

    stateVersion = "25.11";
  };
}
