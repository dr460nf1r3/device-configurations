{ config, pkgs, lib, ... }:
{
  isoImage.volumeID = lib.mkForce "id-live";
  isoImage.isoName = lib.mkForce "id-live.iso";

  imports = [
    ../../configurations/chaotic.nix
    ../../configurations/common.nix
    #../../configurations/desktops.nix
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-base.nix>
  ];

  # use the latest Linux kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Increase timeout
  boot.loader.timeout = lib.mkForce 10;

  # Needed for https://github.com/NixOS/nixpkgs/issues/58959
  boot.supportedFilesystems = lib.mkForce [ "btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs" "zfs" ];

  # This is a live USB
  networking.hostName = "live-usb";

  # Otherwise set to "no" by my config
  services.openssh.settings.PermitRootLogin = lib.mkForce "yes";

  # Allow the usage of Calamares
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }q
    });
  '';

  # Enable the X server with all the drivers
  services.xserver = {
    displayManager = {
      autoLogin = { enable = true; user = "nico"; };
    };
    videoDrivers = [ "nvidia" "amdgpu" "vesa" "modesetting" ];
  };
}
