{ pkgs, lib, config, sources, ... }:
let
  base16-schemes = pkgs.fetchFromGitHub {
    owner = "tinted-theming";
    repo = "base16-schemes";
    rev = "cf6bc89";
    sha256 = "U9pfie3qABp5sTr3M9ga/jX8C807FeiXlmEZnC4ZM58=";
  };

  monitorsXmlContent = builtins.readFile ../../hosts/slim-lair/monitors.xml;
  monitorsConfig = pkgs.writeText "gdm_monitors.xml" monitorsXmlContent;

  nixos-conf-editor = (import (pkgs.fetchFromGitHub {
    owner = "vlinkz";
    repo = "nixos-conf-editor";
    rev = "0.1.1";
    sha256 = "sha256-TeDpfaIRoDg01FIP8JZIS7RsGok/Z24Y3Kf+PuKt6K4=";
  })) { };
  nix-software-center = (import (pkgs.fetchFromGitHub {
    owner = "vlinkz";
    repo = "nix-software-center";
    rev = "0.1.1";
    sha256 = "0frigabszyfkphfbsniaa1d546zm8a2gx0cqvk2fr2qfa71kd41n";
  })) { };
in
{
  # Enable GNOME desktop environment with autologin
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager = {
      gdm = {
        autoSuspend = false;
        enable = true;
      };
      autoLogin = {
        enable = true;
        user = "nico";
      };
    };
  };

  # Enable Wayland for a lot of apps
  environment.sessionVariables = {
    BEMENU_BACKEND = "wayland";
    CLUTTER_BACKEND = "wayland";
    ECORE_EVAS_ENGINE = "wayland_egl";
    ELM_ENGINE = "wayland_egl";
    GDK_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "0";
    QT_QPA_PLATFORM = "wayland-egl";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    SAL_USE_VCLPLUGIN = "gtk3";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  # Needed fix for autologin
  systemd.services = {
    "autovt@tty1".enable = false;
    "getty@tty1".enable = false;
  };

  # Style the operating system using Stylix
  stylix.base16Scheme = "${base16-schemes}/gruvbox-dark-hard.yaml";
  stylix.image = pkgs.fetchurl {
    url = "https://gruvbox-wallpapers.onrender.com/wallpapers/anime/wall.jpg";
    sha256 = "sha256-Dt5A3cA5M+g82RiZn1cbD7CVzAz/b8c1nTEpkp273/s=";
  };
  stylix.polarity = "dark";
  stylix.fonts = {
    serif = config.stylix.fonts.sansSerif;
    sansSerif = {
      package = pkgs.fira;
      name = "Fira Sans";
    };
    monospace = {
      package = pkgs.jetbrains-mono;
      name = "Jetbrains Mono Nerd Font";
    };
    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };

  # Remove a few applications that I don't like
  environment.gnome.excludePackages = (with pkgs; [
    gnome-console
    gnome-photos
    gnome-tour
    xterm
  ]) ++ (with pkgs.gnome; [
    atomix
    cheese
    epiphany
    evince
    geary
    gedit
    gnome-characters
    gnome-music
    hitori
    iagno
    pkgs.gnome-text-editor
    simple-scan
    tali
    totem
  ]);

  # Additional GNOME packages not included by default
  environment.systemPackages = with pkgs; [
    dconf2nix
    evince
    gnome.gnome-boxes
    gnome.gnome-tweaks
    gnomeExtensions.expandable-notifications
    gnomeExtensions.gsconnect
    gnomeExtensions.pano
    gnomeExtensions.unite
    nixos-conf-editor
    nix-software-center
    tilix
  ];
  services.dbus.packages = [ pkgs.dconf pkgs.gnomeExtensions.pano ];
  services.geoclue2.enable = true;
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  # Allow using online accounts
  services.gnome.gnome-online-accounts.enable = true;
  services.gnome.glib-networking.enable = true;

  # Support Firefox if enabled
  programs.firefox.nativeMessagingHosts.gsconnect = true;

  # GSConnect to connect my phone
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  # Enable the GNOME keyring
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.nico.enableGnomeKeyring = true;

  # Apply monitor config on GDM
  systemd.tmpfiles.rules = [
    "L+ /run/gdm/.config/monitors.xml - - - - ${monitorsConfig}"
  ];
}
