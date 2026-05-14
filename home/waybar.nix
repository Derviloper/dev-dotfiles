{ ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = false;

    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 30;

      modules-left = [ "hyprland/workspaces" "hyprland/window" ];
      modules-center = [ "clock" ];
      modules-right = [ "pulseaudio" "network" "tray" ];

      "hyprland/workspaces" = {
        format = "{id}";
        on-click = "activate";
      };

      "hyprland/window" = {
        max-length = 60;
      };

      clock = {
        format = "{:%a %d.%m.%Y  %H:%M}";
        tooltip-format = "<tt>{calendar}</tt>";
      };

      pulseaudio = {
        format = "{volume}% {icon}";
        format-muted = "muted";
        format-icons = {
          default = [ "" "" "" ];
        };
        on-click = "pavucontrol";
      };

      network = {
        format-wifi = "{essid} ({signalStrength}%) ";
        format-ethernet = "{ipaddr} ";
        format-disconnected = "disconnected";
        tooltip-format = "{ifname}: {ipaddr}";
      };

      tray = {
        spacing = 8;
      };
    };

    style = ''
      * {
        font-family: "MesloLGS Nerd Font";
        font-size: 13px;
      }

      window#waybar {
        background: rgba(20, 20, 28, 0.85);
        color: #e5e5e5;
      }

      #workspaces button {
        padding: 0 8px;
        color: #aaaaaa;
      }

      #workspaces button.active {
        color: #ffffff;
        background: rgba(255, 255, 255, 0.1);
      }

      #clock, #pulseaudio, #network, #tray {
        padding: 0 10px;
      }
    '';
  };
}
