{
  config,
  lib,
  pkgs,
  ...
}:

{
  # OBS Studio
  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio.override {
      cudaSupport = true;
    };
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };

  home.packages = with pkgs; [
    gnome-tweaks
    evolution
    telegram-desktop
    fastfetch
    hyfetch
    fractal
    (lib.hiPrio gcc)
    gdb
    llvm
    lldb
    clang
    cmake
    gnumake
    meson
    ninja
    cargo
    rustc
    android-tools
    nixfmt
    nil
    uv
    python313Packages.python-lsp-server
    rust-analyzer
    clang-tools
    guile
    xmake
    just
    psmisc
    papers
    yarn
    pnpm
    nodejs
    deno
    ffmpeg
    imagemagick
    darktable
    davinci-resolve
    github-desktop
    gh
    go
    gnome-software
    nix-index
    file-roller
    wemeet
    file
    nixfmt
    nixfmt-tree
    cider-2
  ];
}
