{
  username,
  homeDirectory,
  dotfiles,
  config,
  ...
}:
{
  programs = {
    home-manager.enable = true;
  };

  home = {
    username = username;
    homeDirectory = homeDirectory;

    stateVersion = "25.11";
  };

  xdg.configFile."sxhkd/sxhkdrc".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/dotfiles/sxhkd/sxhkdrc";
}
