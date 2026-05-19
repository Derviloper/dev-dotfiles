{ username, ... }:
{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  users.users.${username}.openssh.authorizedKeys.keys = [
    # Add your host's public key here, e.g.:
    # "ssh-ed25519 AAAA... your@host"
  ];
}
