{
  system.autoUpgrade = {
    enable = true;
    flake = "github:Derviloper/dev-dotfiles";
    flags = [ "-L" ];
    dates = "weekly";
    randomizedDelaySec = "45min";
  };
}
