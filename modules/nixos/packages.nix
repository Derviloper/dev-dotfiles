{ pkgsUnstable, ... }:
{
  environment.systemPackages = with pkgsUnstable; [
    brave
    btop
    fzf
    ghostty
    nixfmt
    sxhkd
    vscode
    zsh
    zsh-powerlevel10k
    libsecret
    gnome-keyring
  ];
}
