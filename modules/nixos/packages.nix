{ pkgs, ... }:
{
  environment.systemPackages = with pkgs.unstable; [
    btop
    fzf
    nixfmt
    sxhkd
    zsh
    zsh-powerlevel10k
    libsecret
    gnome-keyring
  ];
}
