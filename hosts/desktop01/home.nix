{ username, ... }:
{
  programs = {
    home-manager.enable = true;
  };

  home = {
    username = username;
    homeDirectory = "/home/${username}";

    stateVersion = "25.11";
  };
}
