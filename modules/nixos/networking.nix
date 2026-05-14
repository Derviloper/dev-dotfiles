{ ... }:

{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;

    firewall = {
      allowedTCPPorts = [
        80
        443
        5173
        5174
        5175
        5176
      ];
    };
  };
}
