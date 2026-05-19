{
  virtualisation.vmware.guest.enable = true;

  fileSystems."/mnt/hgfs" = {
    device = ".host:/";
    fsType = "fuse./run/current-system/sw/bin/vmhgfs-fuse";
    options = [
      "allow_other"
      "auto_unmount"
      "defaults"
      "gid=100"
      "uid=1000"
      "umask=022"
      "nofail"
      "x-systemd.automount"
      "x-systemd.idle-timeout=60"
      "x-systemd.mount-timeout=5s"
    ];
  };
}
