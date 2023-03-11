{ pkgs, inputs, ... }:
{
  # Import individual configuration snippets
  imports = [
    ./chromium.nix
    ./connectivity.nix
    ./development.nix
    ./firefox.nix
    ./fonts.nix
    ./games.nix
    ./gnome.nix
    ./impermanence.nix
    ./networking.nix
    ./performance.nix
    ./school.nix
    ./sound.nix
    ./yubikey.nix
  ];

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
    libva-utils
    lm_sensors
    neofetch
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

  # Spotify via spotify-tui & spotifyd
  services.spotifyd = {
    enable = true;
    settings.global = {
      autoplay = true;
      backend = "alsa";
      bitrate = 320;
      cache_path = "/var/cache/spotifyd";
      control = "alsa_audio_device";
      dbus_type = "session";
      device = "alsa_audio_device";
      device_name = "NixOS";
      device_type = "speaker";
      initial_volume = "90";
      max_cache_size = 1000000000;
      mixer = "PCM";
      normalisation_pregain = -10;
      password_cmd = "cat /var/persistent/pass/spot";
      use_mpris = true;
      username = "spotify@dr460nf1r3.org";
      volume_controller = "alsa";
      volume_normalisation = true;
      zeroconf_port = 1234;
    };
  };

  # Waydroid for Android apps
  virtualisation.waydroid.enable = true;

  # For out-of-box gaming with Heroic Game Launcher
  services.flatpak.enable = true;
}
