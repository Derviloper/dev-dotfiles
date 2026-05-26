{ config, pkgs, dotfiles, ... }:
{
  home.packages = [ pkgs.eww ];

  xdg.configFile."eww/eww.yuck".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/modules/home-manager/eww/eww.yuck";
  xdg.configFile."eww/eww.scss".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/modules/home-manager/eww/eww.scss";
  xdg.configFile."eww/workspaces.sh".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/modules/home-manager/eww/workspaces.sh";
}
