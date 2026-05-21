{
  pkgs,
  username,
  homeDirectory,
  dotfiles,
  ...
}:
{
  systemd.tmpfiles.rules = [
    "d ${homeDirectory}/Projects 0755 ${username} users -"
  ];

  systemd.services.checkout-dotfiles = {
    description = "Clone dotfiles repository on first boot";
    wantedBy = [ "multi-user.target" ];
    after = [
      "network-online.target"
      "local-fs.target"
    ];
    wants = [ "network-online.target" ];
    before = [
      "display-manager.service"
      "getty@tty1.service"
    ];
    unitConfig.ConditionPathExists = "!${dotfiles}/.git";
    serviceConfig = {
      Type = "oneshot";
      User = username;
      Group = "users";
      Environment = [
        "GIT_SSL_CAINFO=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
        "HOME=${homeDirectory}"
      ];
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${dotfiles}";
      ExecStart = "${pkgs.git}/bin/git clone https://github.com/Derviloper/dev-dotfiles ${dotfiles}";
    };
  };
}
