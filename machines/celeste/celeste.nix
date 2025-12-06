# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./system/hardware-configuration.nix

    ../../global/system/binary-compatibility.nix
    ../../global/system/bluetooth.nix
    ../../global/system/cups.nix
    ../../global/system/fonts.nix
    ../../global/system/kernel.nix
    ../../global/system/net.nix
    ../../global/system/nix.nix
    ../../global/system/tzlocale.nix

    ../../global/software/misc.nix
    ../../global/software/fcitx.nix
    ../../global/software/libvirt.nix
    ../../global/software/dae.nix
    ../../global/software/emacs.nix
    ../../global/software/kmscon.nix
    ../../global/software/steam.nix

    ../../global/desktops/gnome.nix

    ./system/fix-iwlwifi-bluetooth.nix
    ./system/nvidia.nix
    ./system/users.nix
    ./system/boot.nix

    ./software/1password.nix
    ./software/misc.nix
    ./software/packages.nix
  ];

  networking.hostName = "celeste"; # Define your hostname.
  networking.hostId = "a12be02d"; # For zfs; Make it random!

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}
