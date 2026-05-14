{ ... }:

{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = true;
        grace = 2;
      };

      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      input-field = [
        {
          size = "300, 50";
          position = "0, -100";
          halign = "center";
          valign = "center";
          outline_thickness = 2;
          inner_color = "rgba(20, 20, 28, 0.8)";
          outer_color = "rgba(255, 255, 255, 0.3)";
          font_color = "rgba(229, 229, 229, 1)";
          placeholder_text = "Password";
          fade_on_empty = true;
        }
      ];

      label = [
        {
          text = "$TIME";
          font_size = 64;
          font_family = "MesloLGS Nerd Font";
          color = "rgba(229, 229, 229, 1)";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
