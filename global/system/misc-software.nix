{
  config,
  lib,
  pkgs,
  ...
}:

{
  # FireFox
  programs.firefox.enable = true;

  # Flatpak
  # More configurations are placed in the home-manager nix-flatpak module.
  services.flatpak.enable = true;

  # PolicyKit
  security.polkit.enable = true;
  
  # direnv
  programs.direnv.enable = true;
}
