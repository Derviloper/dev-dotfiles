{
  pkgs,
  username,
  dotfiles,
  ...
}:
{
  system.activationScripts.checkoutDotfiles.text = ''
    if [ ! -d ${dotfiles}/.git ]; then
      mkdir -p ${dotfiles}
      ${pkgs.git}/bin/git clone https://github.com/Derviloper/dev-dotfiles ${dotfiles}
      chown -R ${username}:users ${dotfiles}
    fi
  '';
}
