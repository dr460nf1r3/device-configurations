{ pkgs, lib, config, sources, ... }:
let
  base16-schemes = pkgs.fetchFromGitHub {
    owner = "tinted-theming";
    repo = "base16-schemes";
    rev = "cf6bc89";
    sha256 = "U9pfie3qABp5sTr3M9ga/jX8C807FeiXlmEZnC4ZM58=";
  };
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

  # Enable Wayland for Electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Needed fix for autologin
  systemd.services = {
    "autovt@tty1".enable = false;
    "getty@tty1".enable = false;
  };

  # Exclude bloated packages
  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
    gnome-user-docs
  ])
  ++ (with pkgs.gnome; [
    atomix
    cheese
    epiphany
    evince
    gedit
    gnome-characters
    gnome-maps
    gnome-music
    gnome-software
    gnome-terminal
    gnome-weather
    hitori
    iagno
    pkgs.gnome-text-editor
    simple-scan
    tali
    totem
    yelp
  ]);

  # Style the operating system using Stylix
  stylix.base16Scheme = "${base16-schemes}/gruvbox-dark-hard.yaml";
  stylix.image = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/FrenzyExists/wallpapers/main/Gruv/grub-coffee.png";
    sha256 = "sha256-9kOtRpFefKgFLR3gFRfICLwqU3NhjPezDtNTKSuvzIc=";
  };
  stylix.polarity = "dark";
  stylix.fonts = {
    serif = config.stylix.fonts.sansSerif;
    sansSerif = {
      package = pkgs.fira;
      name = "Fira Sans 10";
    };
    monospace = {
      package = pkgs.jetbrains-mono;
      name = "Jetbrains Mono";
    };
    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };

  # Additional GNOME packages not included by default
  environment.systemPackages = with pkgs; [
    gnome.dconf-editor
    gnome.gnome-boxes
    gnome.gnome-tweaks
    gnomeExtensions.blur-my-shell
    gnomeExtensions.burn-my-windows
    gnomeExtensions.desktop-cube
    gnomeExtensions.expandable-notifications
    gnomeExtensions.github-notifications
    gnomeExtensions.gitlab-extension
    gnomeExtensions.gnome-clipboard
    gnomeExtensions.gsconnect
    gnomeExtensions.ideapad-mode
    gnomeExtensions.remove-alttab-delay-v2
    gnomeExtensions.rounded-corners
    gnomeExtensions.rounded-window-corners
    gnomeExtensions.spotify-tray
    gnomeExtensions.syncthing-indicator
    gnomeExtensions.toggle-alacritty
    gnomeExtensions.transparent-window-moving
    gnomeExtensions.unite
  ];
  services.dbus.packages = [ pkgs.dconf ];
  services.geoclue2.enable = true;
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  # Allow using online accounts
  services.gnome.gnome-online-accounts.enable = true;
  services.gnome.glib-networking.enable = true;

  # GSConnect to connect my phone
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  # Enable the GNOME keyring
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.nico.enableGnomeKeyring = true;

  # We might want to remote into this machine
  services.gnome.gnome-remote-desktop.enable = true;
}
