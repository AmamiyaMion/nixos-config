{
  config,
  lib,
  pkgs,
  ...
}:

{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    maple-mono.NF
  ];
  fonts.fontconfig = {
    antialias = true;
    hinting.enable = true;
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      monospace = [ "Maple Mono NF" ];
      sansSerif = [ "Noto Sans CJK SC" ];
      serif = [ "Noto Serif CJK SC" ];
    };
  };
  fonts.fontconfig.useEmbeddedBitmaps = true;

  # bindfs: solve flatpak CJK font issue
  system.fsPackages = [ pkgs.bindfs ];

  fileSystems =
    let
      mkRoSymBind = path: {
        device = path;
        fsType = "fuse.bindfs";
        options = [
          "ro"
          "resolve-symlinks"
          "x-gvfs-hide"
        ];
      };
      aggregated = pkgs.buildEnv {
        name = "system-fonts-and-icons";
        paths =
          config.fonts.packages
          ++ (with pkgs; [
            gnome-themes-extra
          ]);
        pathsToLink = [
          "/share/fonts"
          "/share/icons"
        ];
      };
    in
    {
      "/usr/share/fonts" = mkRoSymBind "${aggregated}/share/fonts";
      "/usr/share/icons" = mkRoSymBind "${aggregated}/share/icons";
    };
}
