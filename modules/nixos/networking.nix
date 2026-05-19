{
  networking = {
    nftables.enable = true;
    firewall.allowedTCPPorts = [
      22
      80
      443
      5173
      5174
      5175
      5176
    ];
  };
}
