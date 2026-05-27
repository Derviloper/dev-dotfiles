{ pkgs, ... }:
{
  environment.systemPackages = with pkgs.unstable; [
    btop
    fzf
    gcc
    gnome-keyring
    gnumake
    libsecret
    nixfmt
    rustup
    sxhkd
    watchexec
    zsh
    zsh-powerlevel10k
  ];
}
