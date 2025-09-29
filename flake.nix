{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    mion-nur.url = "github:AmamiyaMion/nur";
    mion-nur.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.2";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    chaotic.inputs.nixpkgs.follows = "nixpkgs";
    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=latest";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      mion-nur,
      lanzaboote,
      chaotic,
      nix-flatpak,
      nixos-hardware,
      ...
    }:
    {
      nixosConfigurations = {
        Lenovo-82L5 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ({
              nixpkgs.overlays = [
                # My NUR
                (final: prev: {
                  mion-nur = inputs.mion-nur.packages."${prev.system}";
                })

                # fix Tailscale build
                (_: prev: {
                  tailscale = prev.tailscale.overrideAttrs (old: {
                    checkFlags = builtins.map (
                      flag:
                      if prev.lib.hasPrefix "-skip=" flag then
                        flag + "|^TestGetList$|^TestIgnoreLocallyBoundPorts$|^TestPoller$"
                      else
                        flag
                    ) old.checkFlags;
                  });
                })
              ];
            })

            lanzaboote.nixosModules.lanzaboote # Secure Boot

            chaotic.nixosModules.default # Chaotic-Nyx Repository

            nixos-hardware.nixosModules.lenovo-ideapad-15ach6 # nixos-hardware 82L5

            ./configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs.flake-inputs = inputs;
              home-manager.users.mion = ./home/home.nix;
            }
          ];
        };
      };
    };
}
