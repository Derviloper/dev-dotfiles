{
  inputs,
  pkgs,
  username,
  homeDirectory,
  ...
}:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    secrets."ssh/id_ed25519" = {
      owner = username;
      mode = "0600";
      path = "${homeDirectory}/.ssh/id_ed25519";
    };
  };

  systemd.tmpfiles.rules = [
    "d ${homeDirectory}/.ssh 0700 ${username} users -"
  ];

  environment = {
    variables.SOPS_AGE_KEY_CMD = "sudo ${pkgs.unstable.ssh-to-age}/bin/ssh-to-age -private-key -i /etc/ssh/ssh_host_ed25519_key";

    systemPackages = with pkgs.unstable; [
      sops
      ssh-to-age
    ];
  };
}
