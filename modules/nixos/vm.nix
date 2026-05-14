{ ... }:

{
  virtualisation.vmware.guest.enable = true;

  services.xserver.videoDrivers = [ "vmware" ];

  fileSystems."/mnt/hgfs" = {
    device = ".host:/";
    fsType = "fuse./run/current-system/sw/bin/vmhgfs-fuse";
    options = [
      "umask=22"
      "uid=1000"
      "gid=100"
      "allow_other"
      "defaults"
      "auto_unmount"
    ];
  };
}
