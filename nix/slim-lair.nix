{ config, pkgs, lib, ... }: {
  # Individual settings
  imports = [
    ./hardware-configuration/slim-lair.nix
    ./common/common.nix
    ./common/desktops.nix
    ./common/gnome.nix
    ./common/development.nix
  ];

  # Use the systemd-boot EFI boot loader
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
      };
      timeout = 1;
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = [ "zfs" ];
    zfs.requestEncryptionCredentials = false;
    # /tmp on tmpfs
    tmpOnTmpfs = true;
    tmpOnTmpfsSize = "30%";
    # The new AMD Pstate driver & needed modules
    kernelModules = [ "acpi_call" "amdgpu" "amd-pstate=passive" ];
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
    kernelParams = [ "initcall_blacklist=acpi_cpufreq_init" ];
  };

  # Network configuration - id for ZFS
  networking.hostName = "slim-lair";
  networking.hostId = (builtins.substring 0 8 (builtins.readFile "/etc/machine-id"));

  # SSD
  services.fstrim.enable = true;

  # AMD GPU
  services.xserver.videoDrivers = [ "amdgpu" ];

  # OpenGL support
  hardware.opengl = {
    driSupport = lib.mkDefault true;
    driSupport32Bit = lib.mkDefault true;
  };

  # Virtualisation / Containerization
  virtualisation.containers.storage.settings = {
    storage = {
      driver = "zfs";
      graphroot = "/var/lib/containers/storage";
      runroot = "/run/containers/storage";
    };

    storage.options.zfs = {
      fsname = "zroot/containers";
      mountopt = "nodev";
    };
  };

  # Enable the touchpad
  environment.systemPackages = with pkgs; [ libinput libinput-gestures ];

  # I can't be bothered to upgrade this manually
  system.autoUpgrade.enable = true;

  # NixOS stuff
  system.stateVersion = "22.11";
}

