{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Amamiya Mion";
    userEmail = "50908468+AmamiyaMion@users.noreply.github.com";
    extraConfig = {
      # For 1Pasword Git SSH Signing
      gpg = {
        format = "ssh";
      };
      "gpg \"ssh\"" = {
        program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
      };
      commit = {
        gpgsign = true;
      };
      user = {
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOrG7IrNH5u3LKXA/W9W/2yV+/lGXT9Ejl8FOhB28lus";
      };
    };
  };
}
