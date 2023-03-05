{ pkgs, ... }: {
  # List packages
  environment.systemPackages = with pkgs; [
    keybase-gui
    xdg-utils
    teamviewer
    hugo
    bind.dnsutils # "dig"
    heroku
    gitkraken
    ansible
    logstalgia # Chaotic
    shellcheck # Bash-dev 
    shfmt # Bash-dev
    yarn # Front-dev
    jdk8
    vscode
    jetbrains.pycharm-professional
    ventoy-bin-full
    vmware-workstation
    termius
  ];

  # Enable services (automatically includes their apps' packages)
  services.keybase.enable = true;
  services.kbfs.enable = true;

  # Disable nixos-containers (conflicts with virtualisation.containers)
  boot.enableContainers = false;

  # Virtualisation / Containerization.
  virtualisation.podman = {
    enable = true;
    dockerCompat = true; # Podman provides docker
  };

  # Allow to cross-compile to aarch64
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}
