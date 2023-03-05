{
  description = "Nico's Nix flake";

  inputs = {
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixos-unstable";
    };

    keys_nico = {
      url = "https://github.com/dr460nf1r3.keys";
      flake = false;
    };

    src-chaotic-toolbox = {
      url = "github:chaotic-aur/toolbox";
      flake = false;
    };
    src-repoctl = {
      url = "github:cassava/repoctl";
      flake = false;
    };
  };

  outputs = { nixos-unstable, home-manager, ... }@attrs:
    let
      nixos = nixos-unstable;
      system = "x86_64-linux";
      specialArgs = {
        sources = {
          chaotic-toolbox = attrs.src-chaotic-toolbox;
          repoctl = attrs.src-repoctl;
          nixpkgs = nixos-unstable;
        };
        keys = { nico = attrs.keys_nico; };
      };
      overlay-unstable = ({ ... }: {
        nixpkgs.overlays = [
          (final: prev: {
            unstable = nixos-unstable.legacyPackages.${prev.system};
          })
        ];
      });
      defaultModules = [
        #"${nixos}/nixos/modules/profiles/hardened.nix"
        home-manager.nixosModules.home-manager
        overlay-unstable
      ];
    in {
      nixosConfigurations."nixos-tv" = nixos.lib.nixosSystem {
        inherit system;
        specialArgs = specialArgs;
        modules = defaultModules ++ [ ./nixos-tv.nix ];
      };
      nixosConfigurations."slim-lair" = nixos.lib.nixosSystem {
        inherit system;
        specialArgs = specialArgs;
        modules = defaultModules ++ [ ./slim-lair.nix ];
      };
    };
}
