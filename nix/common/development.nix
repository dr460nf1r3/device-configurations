{ pkgs, ... }: {
  # List packages
  environment.systemPackages = with pkgs; [
    ansible
    bind.dnsutils # "dig"
    gitkraken
    heroku
    hugo
    jdk8
    jetbrains.pycharm-professional
    keybase-gui
    logstalgia # Chaotic
    nixfmt
    nixos-generators
    shellcheck # Bash-dev 
    shfmt # Bash-dev
    teamviewer
    termius
    ventoy-bin-full
    vmware-workstation
    vscode
    wireshark
    xdg-utils
    yarn # Front-dev
  ];

  # Enable services (automatically includes their apps' packages)
  services.kbfs.enable = true;
  services.keybase.enable = true;

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
