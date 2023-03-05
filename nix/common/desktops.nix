{ pkgs, inputs, ... }: {
  # Enable sound with Pipewire
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    alsa.enable = true;
    alsa.support32Bit = true;
    enable = true;
    media-session.enable = false;
    pulse.enable = true;
    systemWide = false;
    wireplumber.enable = true;
  };
  environment.variables = {
    SDL_AUDIODRIVER = "pipewire";
    ALSOFT_DRIVERS = "pipewire";
  };

  # Power profiles daemon
  services.power-profiles-daemon.enable = true;

  # LAN discovery
  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;

  # GPU
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
  boot.kernelParams = [
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
  boot.kernel.sysctl = {
    "vm.max_map_count" = 16777216; # helps with Wine ESYNC/FSYNC
  };

  # List the packages I need
  environment.systemPackages = with pkgs; [
    acpi
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
    jetbrains-mono
    libreoffice-fresh
    librewolf
    libva-utils
    lm_sensors
    lutris
    mangohud
    neofetch
    nextcloud-client
    obs-studio-wrapped
    spicetify-cli
    spot
    spotdl
    spotify
    tdesktop
    teamviewer
    thunderbird
    ugrep
    ungoogled-chromium
    usbutils
    vulkan-tools
    wine-staging
    winetricks
    xdg-utils
  ];

  # Override obs-studio with plugins
  nixpkgs.overlays = let
    thisConfigsOverlay = final: prev: {
      # Obs with plugins
      obs-studio-wrapped =
        final.wrapOBS.override { inherit (final) obs-studio; } {
          plugins = with final.obs-studio-plugins; [
            obs-gstreamer
            obs-pipewire-audio-capture
            obs-vaapi
            obs-vkcapture
          ];
        };
    };
  in [ thisConfigsOverlay ];

  # Special apps (requires more than their package to work)
  programs.adb.enable = true;
  programs.gamemode.enable = true;
  programs.steam = { enable = true; };

  # Automatically tune nice levels
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
  };

  # 90% ZRAM as swap
  zramSwap = {
    enable = true;
    memoryPercent = 90;
  };

  # For out-of-box gaming with Heroic Game Launcher
  services.flatpak.enable = true;

  # Fonts
  fonts = {
    enableDefaultFonts = true; # Those fonts you expect every distro to have
    fonts = with pkgs; [
      fira
      fira-code
      font-awesome_4
      font-awesome_5
      jetbrains-mono
      noto-fonts
      noto-fonts-cjk
      open-fonts
      roboto
      ubuntu_font_family
    ];
    fontconfig = {
      cache32Bit = true;
      defaultFonts = {
        monospace = [ "Jetbrains Mono" ];
        sansSerif = [ "Fira" ];
        serif = [ "Fira" ];
      };
    };
  };
}
