{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Emacs
  services.emacs.enable = true;
  services.emacs.package = pkgs.emacs-gtk;

  # Emacs(Client Mode) as default editor
  services.emacs.defaultEditor = true;
}
