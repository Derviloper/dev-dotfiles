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
              local query current preferred
              query=$(xrandr --query)
              current=$(echo "$query" | awk '/^Virtual-1/{f=1; next} /^[A-Za-z]/{f=0} f && /\*/ {print $1; exit}')
              preferred=$(echo "$query" | awk '/^Virtual-1/{f=1; next} /^[A-Za-z]/{f=0} f && /\+/ {print $1; exit}')
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
