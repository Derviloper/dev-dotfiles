{ username, config, ... }:
{
  programs = {
    home-manager.enable = true;
  };

  home = {
    username = username;
    homeDirectory = "/home/${username}";

    stateVersion = "25.11";
  };

  xdg.configFile."sxhkd/sxhkdrc".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/dotfiles/sxhkd/sxhkdrc";
}
