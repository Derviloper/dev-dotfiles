{ pkgs, ... }:
{
  environment.systemPackages = with pkgs.unstable; [
    age
    btop
    fzf
    nixfmt
    sops
    sxhkd
    zsh
    zsh-powerlevel10k
    libsecret
    gnome-keyring
  ];
}
