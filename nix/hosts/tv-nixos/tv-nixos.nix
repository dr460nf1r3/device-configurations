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
    };
    supportedFilesystems = [ "zfs" ];
    zfs = {
      enableUnstable = true;
      requestEncryptionCredentials = false;
    };
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
    #kernelPackages = pkgs.linuxPackages_xanmod_latest;
  };

  # Hostname & hostid for ZFS
  networking.hostName = "tv-nixos";
  networking.hostId = (builtins.substring 0 8 (builtins.readFile "/etc/machine-id"));

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

  # A few secrets
  sops.secrets."host_keys/tv-nixos" = {
    path = "/etc/ssh/ed_25519_keys";
    mode = "0600";
  };
  sops.secrets."machine-id/tv-nixos" = {
    path = "/etc/machine-id";
    mode = "0600";
  };
  sops.secrets."gsconnect/tv-nixos/private" = {
    path = "/home/nico/.config/gsconnect/private.pem";
    mode = "0600";
    owner = config.users.users.nico.name;
  };
  sops.secrets."gsconnect/tv-nixos/certificate" = {
    path = "/home/nico/.config/gsconnect/certificate.pem";
    mode = "0600";
    owner = config.users.users.nico.name;
  };
  sops.secrets."login/id_ed25519" = {
    mode = "0600";
    owner = config.users.users.nico.name;
    path = "/home/nico/.ssh/id_ed25519";
  };
  sops.secrets."api_keys/spotify-tui" = {
    mode = "0600";
    owner = config.users.users.nico.name;
    path = "/home/nico/.config/spotify-tui/client.yml";
  };
  sops.secrets."api_keys/spotify-tui-token" = {
    mode = "0600";
    owner = config.users.users.nico.name;
    path = "/home/nico/.config/spotify-tui/.spotify_token_cache.json";
  };

  # NixOS stuff
  system.stateVersion = "22.11";
}
