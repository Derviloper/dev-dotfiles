{ ... }:

{
  xdg.configFile."ghostty/config".text = ''
    font-family = MesloLGS Nerd Font
    font-size = 12
    theme = catppuccin-mocha
    background-opacity = 0.95
    window-decoration = false
    window-padding-x = 8
    window-padding-y = 8
    shell-integration = zsh
    cursor-style = block
    confirm-close-surface = false
  '';
}
