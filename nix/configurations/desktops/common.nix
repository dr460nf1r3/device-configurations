{ pkgs, inputs, ... }:
{
  # Import individual configuration snippets
  imports = [
    ./chromium.nix
    ./connectivity.nix
    ./development.nix
    ./fonts.nix
    ./games.nix
    ./gnome.nix
    ./impermanence.nix
    ./misc.nix
    ./mozilla.nix
    ./networking.nix
    ./performance.nix
    ./school.nix
    ./sound.nix
    ./yubikey.nix
  ];

  # Load desktop specific configurations
  home-manager.users."nico".imports = [ ../home/desktops.nix ];

  # Power profiles daemon
  services.power-profiles-daemon.enable = true;

  # GPU acceleration
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Microcode and firmware updates
  hardware.cpu.amd.updateMicrocode = true;
  hardware.cpu.intel.updateMicrocode = true;
  services.fwupd.enable = true;

  # Kernel paramters & settings
  boot = {
    kernelParams = [
      # Disable all mitigations
      "mitigations=off"
      "nopti"
      "tsx=on"
      # Laptops and desktops don't need watchdog
      "nowatchdog"
      # https://github.com/NixOS/nixpkgs/issues/35681#issuecomment-370202008
      "systemd.gpt_auto=0"
      # https://www.phoronix.com/news/Linux-Splitlock-Hurts-Gaming
      "split_lock_detect=off"
    ];
    kernel.sysctl = {
      "vm.max_map_count" = 16777216; # helps with Wine ESYNC/FSYNC
    };
  };

  # List the packages I need
  environment.systemPackages = with pkgs; [
    acpi
    asciinema
    aspell
    aspellDicts.de
    aspellDicts.en
    ffmpegthumbnailer
    gimp
    helvum
    hunspell
    hunspellDicts.de_DE
    hunspellDicts.en_US
    inkscape
    libsecret
    libva-utils
    lm_sensors
    obs-studio-wrapped
    tdesktop-userfonts
    thunderbird
    spotify-tui
    prismlauncher-mod
    tor-browser-bundle-bin
    ugrep
    usbutils
    vulkan-tools
    xdg-utils
    yubikey-personalization
    yubioath-flutter
  ];

  # For out-of-box packages using GNOME software
  services.flatpak.enable = true;
}
