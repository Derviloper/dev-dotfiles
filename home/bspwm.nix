{ config, ... }:
let
  dotfiles = "${config.home.homeDirectory}/Projects/dotfiles/dotfiles";
in {
  xdg.configFile."bspwm/bspwmrc".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/bspwm/bspwmrc";

  xdg.configFile."sxhkd/sxhkdrc".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/sxhkd/sxhkdrc";
}
