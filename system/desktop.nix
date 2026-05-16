{ pkgs, ... }: {
  services.xserver.windowManager.bspwm.enable = true;

  services.xserver.displayManager.lightdm = {
    enable = true;
    greeters.gtk.enable = true;
  };

  services.xserver.desktopManager.runXdgAutostartIfNone = false;

  fonts.packages = with pkgs; [
    nerd-fonts.meslo-lg
    nerd-fonts.jetbrains-mono
    font-awesome
  ];
}
