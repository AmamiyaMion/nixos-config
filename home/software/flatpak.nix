{
  config,
  lib,
  pkgs,
  flake-inputs,
  ...
}:

{
  imports = [
    flake-inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];
  services.flatpak.enable = true;
  services.flatpak.update.onActivation = true;
  services.flatpak.packages = [
    "com.github.tchx84.Flatseal"
    "com.mattjakeman.ExtensionManager"
    "com.gopeed.Gopeed"
    "com.qq.QQ"
    "com.tencent.WeChat"
    "com.tencent.wemeet"
    "com.spotify.Client"
    "com.usebottles.bottles"
    "org.localsend.localsend_app"
  ];
}
