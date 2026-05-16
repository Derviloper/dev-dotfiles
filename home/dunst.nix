{ config, ... }:
let
  dotfiles = "${config.home.homeDirectory}/Projects/dotfiles/dotfiles";
in {
  xdg.configFile."dunst/dunstrc".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/dunst/dunstrc";
}
