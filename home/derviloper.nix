{ username, homeDirectory, ... }:
{
  imports = [ ../modules/home-manager ];

  programs.home-manager.enable = true;

  home = {
    inherit username homeDirectory;
    stateVersion = "25.11";
  };
}
