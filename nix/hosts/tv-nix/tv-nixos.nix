{ pkgs, config, lib, ... }:
{
  # Individual settings
  imports = [
    ../../configurations/common.nix
    ../../configurations/desktops.nix
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
        editor = false;
      };
      efi.canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    supportedFilesystems = [ "zfs" ];
    zfs = {
      enableUnstable = true;
      requestEncryptionCredentials = false;
    };
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
  };

  # Base configuration
  networking.hostName = "tv-nixos";
  networking.networkmanager.enable = true;

  # Correct configurations to use on this device, taken from the hardware repo
  boot = {
    extraModprobeConfig = ''
      options bbswitch use_acpi_to_detect_card_state=1
      options thinkpad_acpi force_load=1 fan_control=1
    '';
    kernelModules = [ "tpm-rng" "i915" ];
  };
  environment.variables = {
    VDPAU_DRIVER =
      lib.mkIf config.hardware.opengl.enable (lib.mkDefault "va_gl");
  };
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.opengl.extraPackages = with pkgs; [
    intel-media-driver
    libvdpau-va-gl
    vaapiIntel
  ];

  # SSD
  services.fstrim.enable = true;

  # Enable the Xorg server
  services.xserver.enable = true;

  # Enable automatic login for the user
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "nico";

  # This is not supported
  services.hardware.bolt.enable = false;

  # Enable the touchpad
  environment.systemPackages = with pkgs; [ libinput ];

  # Fix the monitor setup
  home-manager.users.nico = { lib, ... }: {
    home.file.".config/monitors.xml".source = ./monitors.xml;
  };

  # I can't be bothered to upgrade this manually
  system.autoUpgrade.enable = true;

  # NixOS stuff
  system.stateVersion = "22.11";
}
