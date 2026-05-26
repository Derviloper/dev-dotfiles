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
      "sops-install-secrets.service"
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
      Environment = [ "HOME=${homeDirectory}" ];
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${dotfiles}";
      ExecStart = "${pkgs.git}/bin/git clone git@github.com:Derviloper/dev-dotfiles.git ${dotfiles}";
    };
  };
}
