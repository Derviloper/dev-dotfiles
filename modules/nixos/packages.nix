{ pkgs, ... }:
{
  environment.systemPackages = with pkgs.unstable; [
    btop
    fzf
    gnome-keyring
    gnumake
    libsecret
    nixfmt
    sxhkd
    watchexec
    zsh
    zsh-powerlevel10k
  ];
}
