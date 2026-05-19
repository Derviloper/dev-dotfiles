{
  networking = {
    nftables.enable = true;
    firewall.allowedTCPPorts = [
      22
      80
      443
    ];
  };
}
