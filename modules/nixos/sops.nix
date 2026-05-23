{
  inputs,
  username,
  homeDirectory,
  ...
}:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.keyFile = "/var/lib/sops/age/keys.txt";
    secrets = {
      "ssh/private" = {
        owner = username;
        mode = "0600";
        path = "${homeDirectory}/.ssh/id_ed25519";
      };
      "ssh/public" = {
        owner = username;
        mode = "0644";
        path = "${homeDirectory}/.ssh/id_ed25519.pub";
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d ${homeDirectory}/.ssh 0700 ${username} users -"
  ];
}
