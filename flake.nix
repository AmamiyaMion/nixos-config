{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    mion-nur.url = "github:AmamiyaMion/nur";
    mion-nur.input.nixpkgs.follows = "nixpkgs";
    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.2";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, mion-nur, lanzaboote, ... }: {
    nixosConfigurations = {
      Lenovo-82L5 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ({
            nixpkgs.overlays = [
              (final: prev: {
                mion-nur = inputs.mion-nur.packages."${prev.system}";
              })
            ];
          })

          lanzaboote.nixosModules.lanzaboote

          ./configuration.nix

	        home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.mion = ./home/home.nix;
          }
        ];
      };
    };
  };
}

