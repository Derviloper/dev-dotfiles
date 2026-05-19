{ pkgs, ... }:
{
  environment.systemPackages = with pkgs.unstable; [
    fzf
    nixfmt
    sxhkd
    zsh
    zsh-powerlevel10k
    libsecret
    gnome-keyring
  ];
}
