{ pkgs, ... }:
{
  # List all of the packages
  environment.systemPackages = with pkgs; [
    ansible
    bind.dnsutils
    gitkraken
    heroku
    hugo
    jdk8
    jetbrains.pycharm-professional
    keybase-gui
    nixos-generators
    nixpkgs-fmt
    shellcheck
    shfmt
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
        jdinhlife.gruvbox
        ms-azuretools.vscode-docker
        ms-python.python
        ms-python.vscode-pylance
        ms-vscode.hexeditor
        ms-vsliveshare.vsliveshare
        njpwerner.autodocstring
        pkief.material-product-icons
        redhat.vscode-xml
        redhat.vscode-yaml
        timonwong.shellcheck
        tyriar.sort-lines
      ];
    })
    xdg-utils
    yarn
  ];

  # Enable Keybase & its filesystem
  # services.kbfs.enable = true;
  # services.keybase.enable = true;

  # Disable nixos-containers (conflicts with virtualisation.containers)
  boot.enableContainers = false;

  # Wireshark
  programs.wireshark.enable = true;

  # Libvirt & Podman with docker alias
  virtualisation = {
    libvirtd = {
      enable = true;
    };
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
    };
  };

  # Allow to cross-compile to aarch64
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}
