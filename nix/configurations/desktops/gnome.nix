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
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

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
    gnome.gnome-boxes
    gnome.gnome-tweaks
    gnomeExtensions.expandable-notifications
    gnomeExtensions.gsconnect
    gnomeExtensions.pano
    gnomeExtensions.unite
  ];
  services.dbus.packages = [ pkgs.dconf ];
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

  # The new GNOME console sucks
  programs.gnome-terminal.enable = true;

  # Enable the GNOME keyring
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.nico.enableGnomeKeyring = true;

  # We might want to remote into this machine
  services.gnome.gnome-remote-desktop.enable = true;

  # Apply monitor config on GDM
  systemd.tmpfiles.rules = [
    "L+ /run/gdm/.config/monitors.xml - - - - ${monitorsConfig}"
  ];
}
