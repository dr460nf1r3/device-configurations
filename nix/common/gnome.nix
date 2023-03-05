{ pkgs, lib, config, sources, ... }: {
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
      cheese # webcam tool
      gnome-music
      gnome-terminal
      gedit # text editor
      epiphany # web browser
      geary # email reader
      evince # document viewer
      gnome-characters
      totem # video player
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
      yelp
      gnome-maps
      gnome-weather
    ]);

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
