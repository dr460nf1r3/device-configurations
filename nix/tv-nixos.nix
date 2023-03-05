{ pkgs, config, lib, ... }: {
  imports =
    [ ./hardware-configuration.nix ./common/common.nix ./common/desktops.nix ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Base configuration
  networking.hostName = "tv-nixos";
  networking.networkmanager.enable = true;

  # Correct configurations to use on this device, taken from the hardware quirks repo
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
    vaapiIntel
    libvdpau-va-gl
    intel-media-driver
  ];

  # Enable the Xorg server
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment & TV mode
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.desktopManager.plasma5.bigscreen.enable = true;

  # Enable automatic login for the user
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "nico";

  # Enable kdeconnect (opens ports)
  programs.kdeconnect.enable = true;

  # I can't be bothered to upgrade this manually
  system.autoUpgrade.enable = true;

  system.stateVersion = "22.11";
}
