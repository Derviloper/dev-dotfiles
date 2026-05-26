{ homeDirectory, ... }:
{
  home.file.".ssh/id_ed25519.pub".text = ''
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILBm+ebJElO2PL4BqWgb/wdM+QZPYshQRDTSwnBGYobz
  '';

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Derviloper";
        email = "derviloper@gmx.de";
        signingKey = "${homeDirectory}/.ssh/id_ed25519.pub";
      };
      gpg.format = "ssh";
      commit.gpgsign = true;
      tag.gpgsign = true;
    };
  };
}
