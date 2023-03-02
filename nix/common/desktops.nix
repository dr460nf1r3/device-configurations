{ pkgs, ... }: {

  # 90% ZRAM
  zramSwap = {
    enable = true;
    memoryPercent = 90;
  };

  # Supposedly better for the SSD.
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

  # Enable sound with pipewire
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    media-session.enable = false;
    systemWide = false;
    wireplumber.enable = true;
  };

  # Power profiles daemon
  services.power-profiles-daemon.enable = true;

  environment.variables = {
    AE_SINK = "ALSA"; # For Kodi, better latency/volume under pw
    SDL_AUDIODRIVER = "pipewire";
    ALSOFT_DRIVERS = "pipewire";
  };

  # LAN discovery.
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

  # Microcode updates
  hardware.cpu.intel.updateMicrocode = true;
  hardware.cpu.amd.updateMicrocode = true;

  boot.kernelParams = [
    # Disable all mitigations
    "mitigations=off"
    "nopti"
    "tsx=on"

    # Laptops and dekstops don't need Watchdog
    "nowatchdog"

    # https://github.com/NixOS/nixpkgs/issues/35681#issuecomment-370202008
    "systemd.gpt_auto=0"

    # https://www.phoronix.com/news/Linux-Splitlock-Hurts-Gaming
    "split_lock_detect=off"
  ];

  boot.kernel.sysctl = {
    "vm.max_map_count" = 16777216; # helps with Wine ESYNC/FSYNC
  };

  # List packages.
  environment.systemPackages = with pkgs; [
    # Desktop apps
    acpi
    btop
    brightnessctl
    ffmpegthumbnailer
    keybase-gui
    libinput
    libinput-gestures
    libsForQt5.kio # Fixes "Unknown protocol 'file'."
    lm_sensors
    obs-studio-wrapped
    spotify
    tdesktop
    usbutils
    xdg-utils
    teamviewer
    librewolf
    jamesdsp

    # Development apps
    bind.dnsutils # "dig"
    heroku
    logstalgia # Chaotic
    nixpkgs-fmt # Nix
    nixpkgs-review # Nix
    python3Minimal
    shellcheck # Bash-dev
    shfmt # Bash-dev
    yarn # Front-dev

    helvum
    libva-utils
    ugrep
    aspellDicts.en
    aspellDicts.de

    inkscape
    gimp

    # Gaming
    mangohud
    wine-staging
    vulkan-tools
    winetricks
  ];

  # Special apps (requires more than their package to work).
  programs.adb.enable = true;
  programs.gamemode.enable = true;
  programs.steam.enable = true;

  # Override some packages' settings, sources, etc...
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

  # Enable services (automatically includes their apps' packages).
  services.fwupd.enable = true;
  services.keybase.enable = true;
  services.kbfs.enable = true;

  # Fonts.
  fonts = {
    enableDefaultFonts = true; # Those fonts you expect every distro to have.
    fonts = with pkgs; [
      fira
      fira-code
      jetbrains-mono
      font-awesome_4
      font-awesome_5
      noto-fonts
      noto-fonts-cjk
      open-fonts
      roboto
      ubuntu_font_family
    ];
    fontconfig = {
      cache32Bit = true;
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Fira" ];
        monospace = [ "Fira Code" ];
      };
    };
  };

  # For out-of-box gaming with Heroic Game Launcher
  services.flatpak.enable = true;

  # Allow to cross-compile to aarch64
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}
