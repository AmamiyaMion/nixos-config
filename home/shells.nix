{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.bash = {
    enable = true;
  };
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };
}
