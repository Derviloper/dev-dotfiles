{ pkgs, lib, ... }:
{
  systemd.user.services.vmware-autofit = {
    Unit = {
      Description = "Apply preferred resolution to Virtual-1 on RandR changes";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = lib.getExe (
        pkgs.writeShellApplication {
          name = "vmware-autofit";
          runtimeInputs = with pkgs.xorg; [
            xrandr
            xev
          ];
          text = ''
            xrandr --output Virtual-1 --preferred || true
            xev -root -event randr | while IFS= read -r line; do
              if [[ "$line" == RRScreenChangeNotify* ]]; then
                xrandr --output Virtual-1 --preferred || true
              fi
            done
          '';
        }
      );
      Restart = "on-failure";
      RestartSec = 2;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
