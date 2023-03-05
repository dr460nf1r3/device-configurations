{ pkgs, lib, config, sources, ... }:
let
  base16-schemes = pkgs.fetchFromGitHub {
    owner = "tinted-theming";
    repo = "base16-schemes";
    rev = "cf6bc89";
    sha256 = "U9pfie3qABp5sTr3M9ga/jX8C807FeiXlmEZnC4ZM58=";
  };
in {
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
  environment.gnome.excludePackages = (with pkgs; [ gnome-photos gnome-tour ])
    ++ (with pkgs.gnome; [
      atomix # puzzle game
      cheese # webcam tool
      epiphany # web browser
      evince # document viewer
      geary # email reader
      gedit # text editor
      gnome-characters
      gnome-maps
      gnome-music
      gnome-terminal
      gnome-weather
      hitori # sudoku game
      iagno # go game
      tali # poker game
      totem # video player
      yelp # useless help app
    ]);

  # Style the desktop
  stylix.base16Scheme = "${base16-schemes}/gruvbox-dark-soft.yaml";
  stylix.image = pkgs.fetchurl {
    url = "https://gitlab.com/garuda-linux/themes-and-settings/artwork/garuda-wallpapers/-/raw/ac03a670062e80a2c0306bc4c8dd3ae485b4566c/src/garuda-wallpapers/Malefor.jpg";
    sha256 = "865b778723caaa7f3c26bcb2a9e8048257fc4eef2b90fbf788044f22e618cb64";
  };
  stylix.polarity = "dark";
  stylix.fonts = {
    serif = config.stylix.fonts.sansSerif;
    sansSerif = {
      package = pkgs.fira;
      name = "Fira";
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
  environment.systemPackages = with pkgs; [ gnome.gnome-tweaks ];
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  # Allow using online accounts
  services.gnome.gnome-online-accounts.enable = true;

  # Enable the GNOME keyring
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.nico.enableGnomeKeyring = true;

  # We might want to remote into this machine
  services.gnome.gnome-remote-desktop.enable = true;
}
