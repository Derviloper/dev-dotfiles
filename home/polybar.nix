{ config, ... }:
let
  dotfiles = "${config.home.homeDirectory}/Projects/dotfiles/dotfiles";
in {
  xdg.configFile."polybar/config.ini".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/polybar/config.ini";

  xdg.configFile."polybar/launch.sh".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/polybar/launch.sh";
}
