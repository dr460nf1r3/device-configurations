{ lib, pkgs, config, modulesPath, ... }:
with lib;
let
  nixos-wsl = import ./nixos-wsl;
in
{
  # Slimmed down configurations
  imports = [
    ../../configurations/common.nix
    ../../configurations/locales.nix
    ../../configurations/nix.nix
    ../../configurations/shells.nix
    ../../configurations/sops.nix
    ../../configurations/theming.nix
    ../../configurations/users.nix
    ../../overlays/default.nix
    "${modulesPath}/profiles/minimal.nix"
    nixos-wsl.nixosModules.wsl
  ];

  # WSL flake settings
  wsl = {
    enable = true;
    automountPath = "/mnt";
    defaultUser = "nixos";
    startMenuLaunchers = true;

    # Enable native Docker support
    docker-native.enable = true;

    # Enable integration with Docker Desktop (needs to be installed)
    docker-desktop.enable = true;
  };

  # NixOS stuff
  system.stateVersion = "22.05";
}