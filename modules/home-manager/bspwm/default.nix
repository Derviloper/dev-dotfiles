{ config, dotfiles, ... }:
{
  xdg.configFile."bspwm/bspwmrc".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/modules/home-manager/bspwm/bspwmrc";
}
