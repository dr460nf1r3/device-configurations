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
    nixpkgs-fmt
    nixos-generators
    shellcheck # Bash-dev
    shfmt # Bash-dev
    teamviewer
    termius
    ventoy-bin-full
    vscode
    vscode-extensions.b4dm4n.vscode-nixpkgs-fmt
    vscode-extensions.esbenp.prettier-vscode
    vscode-extensions.github.codespaces
    vscode-extensions.github.copilot
    vscode-extensions.jdinhlife.gruvbox
    vscode-extensions.ms-azuretools.vscode-docker
    vscode-extensions.ms-python.python
    vscode-extensions.ms-python.vscode-pylance
    vscode-extensions.ms-vsliveshare.vsliveshare
    vscode-extensions.redhat.vscode-yaml
    vscode-extensions.timonwong.shellcheck
    wireshark
    xdg-utils
    yarn # Front-dev
  ];

  # Enable services (automatically includes their apps' packages)
  services.kbfs.enable = true;
  services.keybase.enable = true;

  # Disable nixos-containers (conflicts with virtualisation.containers)
  boot.enableContainers = false;

  # Virtualisation / Containerization
  virtualisation = {
    # Virtualbox
    virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };
    # VMware workstation
    vmware.host = {
      enable = true;
      #extraConfig = ''
      #'';
    };
    # Podman with Docker alias
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };

  # Allow to cross-compile to aarch64
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}
