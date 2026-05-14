{ pkgsUnstable, ... }:

{
  users.users.daniel-da-silva = {
    isNormalUser = true;
    description = "Daniel da Silva";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  users.defaultUserShell = pkgsUnstable.zsh;
}
