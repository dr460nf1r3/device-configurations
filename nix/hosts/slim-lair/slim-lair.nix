{ config, pkgs, lib, ... }: {
  # Individual settings
  imports = [
    ../../configurations/chaotic.nix
    ../../configurations/common.nix
    ../../configurations/desktops.nix
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
        editor = false;
      };
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = [ "zfs" ];
    zfs = {
      enableUnstable = true;
      requestEncryptionCredentials = false;
    };
    # /tmp on tmpfs
    tmpOnTmpfs = true;
    tmpOnTmpfsSize = "30%";
    # Needed to get the touchpad to work
    blacklistedKernelModules = [ "elan_i2c" ];
    # The new AMD Pstate driver & needed modules
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
    kernelModules = [ "acpi_call" "amdgpu" "amd-pstate=passive" ];
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelParams = [ "initcall_blacklist=acpi_cpufreq_init" ];
  };

  # Creates a second boot entry with LTS kernel and stable ZFS
  specialisation.safe.configuration = {
    boot.kernelPackages = lib.mkForce pkgs.linuxPackages;
    boot.zfs.enableUnstable = lib.mkForce false;
    system.nixos.tags = [ "lts" "zfs-stable" ];
  };

  # Network configuration - id for ZFS
  networking.hostName = "slim-lair";
  networking.hostId = (builtins.substring 0 8 (builtins.readFile "/etc/machine-id"));

  # SSD
  services.fstrim.enable = true;

  # AMD device
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.hardware.bolt.enable = false;

  # Virtualisation / Containerization
  virtualisation.containers.storage.settings = {
    storage = {
      driver = "zfs";
      graphroot = "/var/lib/containers/storage";
      runroot = "/run/containers/storage";
      options.zfs = {
        fsname = "zroot/containers";
        mountopt = "nodev";
      };
    };
  };

  # Enable the touchpad
  environment.systemPackages = with pkgs; [ libinput ];

  # Fix the monitor setup
  home-manager.users.nico = { lib, ... }: {
    home.file.".config/monitors.xml".source = ./monitors.xml;
  };

  # NixOS stuff
  system.stateVersion = "22.11";
}