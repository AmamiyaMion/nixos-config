{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./software/ssh.nix
    ./software/git.nix
    ./software/vscode.nix
    ./software/shells.nix
  ];

  # Zoxide
  programs.zoxide.enable = true;
  programs.zoxide.enableBashIntegration = true;

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
    thunderbird
    telegram-desktop
    fastfetch
    hyfetch
    fractal
    (hiPrio gcc)
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
    qq
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
  ];
}
