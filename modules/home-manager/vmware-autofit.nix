{ pkgs, lib, ... }:
{
  systemd.user.services.vmware-autofit = {
    Unit = {
      Description = "Apply VMware preferred xrandr resolution (bspwm auto-fit)";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = lib.getExe (pkgs.writeShellApplication {
        name = "vmware-autofit";
        runtimeInputs = [ pkgs.xorg.xrandr ];
        text = ''
          while sleep 0.5; do
            xrandr --output Virtual-1 --preferred
          done
        '';
      });
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
