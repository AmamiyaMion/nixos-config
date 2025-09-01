{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    mion-nur.url = "github:AmamiyaMion/nur";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, mion-nur, ... }: {
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
          ./configuration.nix
					home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.mion = ./home.nix;
          }
        ];
      };
    };
  };
}

