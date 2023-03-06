{
  description = "Nico's Nix flake";

  inputs = {
    # We roll unstable, as usual
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Automated system themes - seems to be broken atm
    stylix.url = "github:danth/stylix";
    # All of the VSCode extensions not available in Nixpkgs
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    # Reset rootfs every reboot
    impermanence.url = "github:nix-community/impermanence";
    # Home management
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixos-unstable";
    };
    # Nix user repository
    nur.url = github:nix-community/NUR;
    # My keys
    keys_nico = {
      url = "https://github.com/dr460nf1r3.keys";
      flake = false;
    };
    # The Chaotic toolbox
    src-chaotic-toolbox = {
      url = "github:chaotic-aur/toolbox";
      flake = false;
    };
    src-repoctl = {
      url = "github:cassava/repoctl";
      flake = false;
    };
  };

  outputs = { nixos-unstable, home-manager, stylix, impermanence, ... }@attrs:
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
        "${nixos}/nixos/modules/profiles/hardened.nix"
        home-manager.nixosModules.home-manager
        overlay-unstable
      ];
    in
    {
      # Defines a formatter for "nix fmt"
      formatter.x86_64-linux = nixos-unstable.legacyPackages.x86_64-linux.nixpkgs-fmt;
      # All the systems
      nixosConfigurations."nixos-tv" = nixos.lib.nixosSystem {
        inherit system;
        specialArgs = specialArgs;
        modules = defaultModules ++ [ ./nixos-tv.nix ];
      };
      nixosConfigurations."slim-lair" = nixos.lib.nixosSystem {
        inherit system;
        specialArgs = specialArgs;
        modules = defaultModules ++ [ ./slim-lair.nix stylix.nixosModules.stylix impermanence.nixosModules.impermanence ];
      };
    };
}
