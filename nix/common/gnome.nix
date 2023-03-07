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
  # Enable GNOME desktop environment
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager = {
      gdm.enable = true;
      autoLogin = {
        enable = true;
        user = "nico";
      };
    };
  };

  # Exclude bloated packages
  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
    gnome-user-docs
  ])
  ++ (with pkgs.gnome; [
    atomix # puzzle game
    cheese # webcam tool
    epiphany # web browser
    evince # document viewer
    gedit # text editor
    gnome-characters
    gnome-maps
    simple-scan
    pkgs.gnome-text-editor
    gnome-music
    gnome-software
    gnome-terminal
    gnome-weather
    hitori # sudoku game
    iagno # go game
    tali # poker game
    totem # video player
    yelp # useless help app
  ]);

  # Style the desktop
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

  # Configure Qt theming
  qt = {
    enable = true;
    style = "adwaita";
    platformTheme = "gnome";
  };

  # Additional GNOME packages not included by default
  environment.systemPackages = with pkgs; [ gnome.gnome-tweaks ];
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  # Allow using online accounts
  services.gnome.gnome-online-accounts.enable = true;
  services.gnome.glib-networking.enable = true;

  # GSConnect
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
