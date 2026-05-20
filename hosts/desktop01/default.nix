{
  inputs,
  hostname,
  ...
}:
let
  username = "derviloper";
  homeDirectory = "/home/${username}";
  dotfiles = "${homeDirectory}/Projects/dotfiles";
in
{
  imports = [
    ./hardware.nix
    ./vmware-guest.nix
    ../../modules/nixos
    inputs.home-manager.nixosModules.home-manager
  ];

  _module.args = { inherit username homeDirectory dotfiles; };

  networking.hostName = hostname;
  system.stateVersion = "25.11";

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialHashedPassword = "";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit
        inputs
        username
        homeDirectory
        dotfiles
        ;
    };
    users.${username} = ../../home/derviloper.nix;
  };
}
