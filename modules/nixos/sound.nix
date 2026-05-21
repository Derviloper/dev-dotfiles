{
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;

    # VMware's emulated audio chip (ENS1371) has jittery IRQ delivery; the
    # default 1024-frame period drains before the next interrupt arrives.
    # Larger period + generous headroom absorbs the jitter.
    wireplumber.extraConfig."51-vmware-alsa-buffers" = {
      "monitor.alsa.rules" = [
        {
          matches = [ { "node.name" = "~alsa_output\\..*"; } ];
          actions.update-props = {
            "api.alsa.period-size" = 2048;
            "api.alsa.headroom" = 8192;
            "session.suspend-timeout-seconds" = 0;
          };
        }
      ];
    };
  };
}
