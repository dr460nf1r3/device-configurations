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

  # Needed fix for autologin
  systemd.services = {
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
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

  # Additional GNOME packages not included by default
  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnome.dconf-editor
    gnomeExtensions.burn-my-windows
    gnomeExtensions.space-bar
    gnomeExtensions.username-and-hostname-to-panel
    gnomeExtensions.useless-gaps
    gnomeExtensions.unite
    gnomeExtensions.transparent-window-moving
    gnomeExtensions.toggle-alacritty
    gnomeExtensions.syncthing-indicator
    gnomeExtensions.spotify-tray
    gnomeExtensions.rounded-window-corners
    gnomeExtensions.rounded-corners
    gnomeExtensions.remove-alttab-delay-v2
    gnomeExtensions.project-manager-for-vscode
    gnomeExtensions.ideapad-mode
    gnomeExtensions.gsconnect
    gnomeExtensions.gnome-clipboard
    gnomeExtensions.github-notifications
    gnomeExtensions.gitlab-extension
    gnomeExtensions.expandable-notifications
    gnomeExtensions.dash2dock-lite
    gnomeExtensions.desktop-cube
    gnomeExtensions.compiz-windows-effect
    gnomeExtensions.bubblemail
    gnomeExtensions.blur-my-shell
    gnomeExtensions.arcmenu
  ];
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  services.dbus.packages = [ pkgs.dconf ];
  services.geoclue2.enable = true;

  # Allow using online accounts
  services.gnome.gnome-online-accounts.enable = true;
  services.gnome.glib-networking.enable = true;

  # Enable the GNOME browser integration
  services.xserver.desktopManager.gnome.sessionPath = [ pkgs.gnome.gnome-shell-extensions ];

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
