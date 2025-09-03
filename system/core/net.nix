{
  config,
  lib,
  pkgs,
  ...
}:

{
  networking.hostName = "Lenovo-82L5"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  networking.hostId = "a12be02d"; # For zfs; Make it random!

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Tailscale
  services.tailscale.enable = true;

  networking.nameservers = [
    # "100.100.100.100" # Tailscale DNS: for Tailscale MagicDNS
    "119.29.29.29" # Tencent
    "223.5.5.5" # AliDNS
    "8.8.4.4" # Google
    "1.1.1.1" # Cloudflare
    "9.9.9.9" # Quad9
  ];
  # networking.search = [
  #   "taild9dbd6.ts.net" # Tailscale DNS: for Tailscale MagicDNS
  # ];

}
