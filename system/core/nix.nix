{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Enable nix command and flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Mirror
  nix.settings.substituters = [
    "https://mirror.sjtu.edu.cn/nix-channels/store"
    "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
  ];

  # Allow non-free software
  nixpkgs.config.allowUnfree = true;
}
