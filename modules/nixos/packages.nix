{ pkgs, ... }:
{
  environment.systemPackages = with pkgs.unstable; [
    btop
    dig
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
