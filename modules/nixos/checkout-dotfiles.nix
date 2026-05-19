{
  pkgs,
  username,
  dotfiles,
  ...
}:
{
  systemd.services.checkout-dotfiles = {
    description = "Clone dotfiles repository";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];

    serviceConfig = {
      Type = "oneshot";
      User = username;
      Group = "users";
    };

    path = [
      pkgs.git
      pkgs.openssh
    ];

    script = ''
      if [ ! -d ${dotfiles}/.git ]; then
        mkdir -p ${dotfiles}
        git clone https://github.com/Derviloper/dev-dotfiles ${dotfiles}
      fi
    '';
  };
}
