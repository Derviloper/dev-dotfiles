{ homeDirectory, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."homelab" = {
      hostname = "homelab";
      user = "admin";
      identityFile = "${homeDirectory}/.ssh/id_ed25519";
    };
  };
}
