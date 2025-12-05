{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./software/fcitx.nix
    ./software/dae.nix
    ./software/libvirt.nix
  ];

  # FireFox
  programs.firefox.enable = true;

  # Flatpak
  services.flatpak.enable = true;

  # Clash Verge Rev
  programs.clash-verge.enable = true;
  programs.clash-verge.autoStart = true;
  programs.clash-verge.serviceMode = true;

  # 1Password
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = [ "mion" ];
  };
  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        google-chrome-stable
        firefox
        zen
        zen-bin
      '';
      mode = "0755";
    };
  };

  # AppImage
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  # nix-ld
  programs.nix-ld.enable = true;

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # ratbagd (for piper)
  services.ratbagd.enable = true;

  security.polkit.enable = true;

  # Emacs
  services.emacs.enable = true;
  services.emacs.package = pkgs.emacs-gtk;

  # direnv
  programs.direnv.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages =
    with pkgs;
    [
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
      micro
      lshw
      gtop # for GNOME Shell Plugin
      pciutils
      nethogs
      iotop
      htop
      btop
      hplip
      ripgrep
      iw
      amdgpu_top
      piper
      bat
      sbctl
      xclip
      wl-clipboard
      fd
      ispell
      libreoffice-fresh
      hunspell
      hunspellDicts.en_US
      zen-browser.default
    ];
}
