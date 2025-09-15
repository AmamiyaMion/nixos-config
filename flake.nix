{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    mion-nur.url = "github:AmamiyaMion/nur";
    mion-nur.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.2";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
    lix = {
      url = "https://git.lix.systems/lix-project/lix/archive/main.tar.gz";
      flake = false;
    };
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.lix.follows = "lix";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      mion-nur,
      lanzaboote,
      lix-module,
      lix,
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

            lix-module.nixosModules.default # Use Lix instead of CppNix

            lanzaboote.nixosModules.lanzaboote # Secure Boot

            ./configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.mion = ./home/home.nix;
            }
          ];
        };
      };
    };
}
