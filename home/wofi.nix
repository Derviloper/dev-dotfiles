{ pkgs, ... }:

{
  home.packages = [ pkgs.wofi ];

  xdg.configFile."wofi/config".text = ''
    show=drun
    width=600
    height=400
    location=center
    allow_markup=true
    no_actions=true
    insensitive=true
    prompt=Search...
  '';

  xdg.configFile."wofi/style.css".text = ''
    window {
      background-color: rgba(20, 20, 28, 0.95);
      border: 1px solid #444;
      border-radius: 8px;
      font-family: "MesloLGS Nerd Font";
      font-size: 13px;
      color: #e5e5e5;
    }

    #input {
      margin: 8px;
      padding: 6px 10px;
      border-radius: 6px;
      background: rgba(255, 255, 255, 0.08);
      border: none;
      color: #ffffff;
    }

    #entry:selected {
      background: rgba(255, 255, 255, 0.12);
      border-radius: 6px;
    }
  '';
}
