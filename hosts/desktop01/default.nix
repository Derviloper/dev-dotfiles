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
    ./disko.nix
    ./vmware-guest.nix
    ../../modules/nixos
    inputs.disko.nixosModules.disko
    inputs.home-manager.nixosModules.home-manager
  ];

  _module.args = { inherit username homeDirectory dotfiles; };

  networking.hostName = hostname;
  system.stateVersion = "25.11";

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "pipewire"
    ];
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
