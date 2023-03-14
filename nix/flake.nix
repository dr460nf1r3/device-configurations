{
  description = "Nico's Nix flake";

  inputs = {
    # We roll unstable, as usual
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Automated system themes
    stylix.url = "github:danth/stylix";
    # Smooth-criminal bleeding-edge Mesa3D
    mesa-git-src = {
      url = "github:chaotic-aur/mesa-mirror/main";
      flake = false;
    };
    # Secure boot support
    lanzaboote.url = "github:nix-community/lanzaboote";
    # Secrets management
    sops-nix.url = "github:Mic92/sops-nix";
    # In case I need to generate a build
    # nixos-generators = {
    #   url = "github:nix-community/nixos-generators";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # Fancy Gruvbox Spotify
    # spicetify-nix.url = github:the-argus/spicetify-nix;
    # Reset rootfs every reboot
    impermanence.url = "github:nix-community/impermanence";
    # Home management - https://github.com/nix-community/home-manager/issues/3671
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixos-unstable";
    };
    # Prismlauncher
    nix-minecraft = {
      url = "github:misterio77/nix-minecraft";
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

  outputs = { nixos-unstable, home-manager, stylix, impermanence, nur, sops-nix, lanzaboote, ... }@attrs:
    let
      nixos = nixos-unstable;
      system = "x86_64-linux";
      specialArgs = {
        sources = {
          chaotic-toolbox = attrs.src-chaotic-toolbox;
          nixpkgs = nixos-unstable;
          repoctl = attrs.src-repoctl;
        };
        keys = { nico = attrs.keys_nico; };
      };
      overlay-unstable = ({ ... }: {
        nixpkgs.overlays = [
          (final: prev: {
            unstable = nixos-unstable.legacyPackages.${prev.system};
          })
          nur.overlay
        ];
      });
      defaultModules = [
        home-manager.nixosModules.home-manager
        nur.nixosModules.nur
        overlay-unstable
        sops-nix.nixosModules.sops
        stylix.nixosModules.stylix
      ];
    in
    {
      # Defines a formatter for "nix fmt"
      formatter.x86_64-linux = nixos-unstable.legacyPackages.x86_64-linux.nixpkgs-fmt;

      # All the system configurations
      # My old laptop serving as TV
      nixosConfigurations."tv-nixos" = nixos.lib.nixosSystem {
        inherit system;
        modules = defaultModules ++ [
          ./hosts/tv-nixos/tv-nixos.nix
          impermanence.nixosModules.impermanence
        ];
        specialArgs = specialArgs;
      };
      # My main device (Lenovo Slim 7)
      nixosConfigurations."slim-lair" = nixos.lib.nixosSystem {
        inherit system;
        modules = defaultModules ++ [
          ./hosts/slim-lair/slim-lair.nix
          impermanence.nixosModules.impermanence
          lanzaboote.nixosModules.lanzaboote
        ];
        specialArgs = specialArgs;
      };
      # For WSL, mostly used at work only
      nixosConfigurations."wsl-nixos" = nixos.lib.nixosSystem {
        inherit system;
        modules = defaultModules ++ [
          ./hosts/wsl-nixos/wsl-nixos.nix
        ];
        specialArgs = specialArgs;
      };
      # To-do for installations
      nixosConfigurations."live-usb" = nixos.lib.nixosSystem {
        inherit system;
        modules = defaultModules ++ [
          ./hosts/live-usb/live-usb.nix
        ];
        specialArgs = specialArgs;
      };

      # Host dependant home-manager configurations
      homeConfigurations = {
        "nico@slim-lair" = home-manager.lib.homeManagerConfiguration {
          modules = [ ./home/slim-lair.nix ];
        };
      };
      homeConfigurations = {
        "nico@tv-nixos" = home-manager.lib.homeManagerConfiguration {
          modules = [ ./home/tv-nixos.nix ];
        };
      };
    };
}
