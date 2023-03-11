{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # Our ZFS pool
  fileSystems."/" = {
    device = "zroot/ROOT/empty";
    fsType = "zfs";
    neededForBoot = true;
  };
  fileSystems."/nix" = {
    device = "zroot/ROOT/nix";
    fsType = "zfs";
  };
  fileSystems."/home/nico/Games" = {
    device = "zroot/games/home";
    fsType = "zfs";
  };
  fileSystems."/var/persistent" = {
    device = "zroot/data/persistent";
    fsType = "zfs";
    neededForBoot = true;
  };
  fileSystems."/var/residues" = {
    device = "zroot/ROOT/residues";
    fsType = "zfs";
    neededForBoot = true;
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/C6F4-A419";
    fsType = "vfat";
  };

  # Intel device
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
