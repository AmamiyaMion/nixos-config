{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./fcitx.nix
    ./dae.nix
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
      '';
      mode = "0755";
    };
  };

  # AppImage
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  # Virt-manager & libvirt
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "mion" ];
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          (pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd
        ];
      };
    };
  };
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.libvirtd.qemu.vhostUserPackages = [ pkgs.virtiofsd ];

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # ratbagd (for piper)
  services.ratbagd.enable = true;

  # For OBS Studio Virtual Camera: v2l4loopback kernel module
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  security.polkit.enable = true;

  # Emacs
  services.emacs.enable = true;
  services.emacs.package = pkgs.emacs-gtk;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
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
    mion-nur.bash-pinyin-completion-rs
    xclip
    wl-clipboard
    fd
  ];
}
