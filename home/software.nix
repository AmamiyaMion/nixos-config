{ config, lib, pkgs, ... }:

{
  imports = [
    ./ssh.nix
    ./git.nix
    ./vscode.nix
    ./shells.nix
  ];

  # Zoxide
  programs.zoxide.enable = true;
  programs.zoxide.enableBashIntegration= true;

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
  ];
}
