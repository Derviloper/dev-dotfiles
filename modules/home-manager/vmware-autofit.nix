{ pkgs, lib, ... }:
{
  systemd.user.services.vmware-autofit = {
    Unit = {
      Description = "Apply VMware preferred xrandr resolution (bspwm auto-fit)";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = lib.getExe (
        pkgs.writeShellApplication {
          name = "vmware-autofit";
          runtimeInputs = with pkgs; [
            xorg.xrandr
            xorg.xev
            coreutils
            gawk
          ];
          text = ''
            apply_if_needed() {
              local current preferred
              read -r current preferred < <(xrandr --query | awk '
                /^[^[:space:]]/ { in_section = ($1 == "Virtual-1"); next }
                in_section && !c && index($0, "*") { c = $1 }
                in_section && !p && index($0, "+") { p = $1 }
                END { print c, p }
              ')
              if [ -n "$preferred" ] && [ "$current" != "$preferred" ]; then
                xrandr --output Virtual-1 --preferred
              fi
            }

            apply_if_needed
            xev -root -event randr | while IFS= read -r line; do
              case "$line" in
                *RRScreenChangeNotify*) apply_if_needed ;;
              esac
            done
          '';
        }
      );
      Restart = "always";
      RestartSec = "2s";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
