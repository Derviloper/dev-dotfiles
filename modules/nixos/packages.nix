{ pkgs, ... }:
{
  environment.systemPackages = with pkgs.unstable; [
    btop
    fzf
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
