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
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
      b4dm4n.vscode-nixpkgs-fmt
      bbenoist.nix
      eamodio.gitlens
      esbenp.prettier-vscode
      foxundermoon.shell-format
      github.codespaces
      github.copilot
      ms-azuretools.vscode-docker
      ms-python.python
      ms-python.vscode-pylance
      ms-vscode.hexeditor
      ms-vsliveshare.vsliveshare
      njpwerner.autodocstring
      redhat.vscode-xml
      redhat.vscode-yaml
      timonwong.shellcheck
      tyriar.sort-lines
      ];
    })
    wireshark
    xdg-utils
    yarn # Front-dev
  ];

  # Enable Wayland for vscode
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

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
