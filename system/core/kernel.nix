{
  config,
  lib,
  pkgs,
  ...
}:

{
  boot.kernelPackages = pkgs.linuxPackages_cachyos-gcc;
  boot.zfs.package = pkgs.zfs_cachyos;
  services.scx.enable = true; # Use sched_ext
}
