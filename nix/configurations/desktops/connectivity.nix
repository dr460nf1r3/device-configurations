{ pkgs, config, ... }:
{
  # LAN discovery
  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;

  # Special apps
  programs.adb.enable = true;
}
