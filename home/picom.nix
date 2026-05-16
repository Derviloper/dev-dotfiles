{ config, ... }:
let
  dotfiles = "${config.home.homeDirectory}/Projects/dotfiles/dotfiles";
in {
  xdg.configFile."picom/picom.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/picom/picom.conf";
}
