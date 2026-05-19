{ config, dotfiles, ... }:
{
  xdg.configFile."sxhkd/sxhkdrc".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/modules/home-manager/sxhkd/sxhkdrc";
}
