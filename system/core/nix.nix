{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Use Lix [Moved to flake.nix]
  # nixpkgs.overlays = [
  #   (final: prev: {
  #     inherit (final.lixPackageSets.git)
  #       nixpkgs-review
  #       nix-direnv
  #       nix-eval-jobs
  #       nix-fast-build
  #       colmena
  #       ;
  #   })
  # ];
  # nix.package = pkgs.lixPackageSets.stable.lix;

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
