{ pkgs, ... }:
{
  # List all of the packages
  environment.systemPackages = with pkgs; [
    ansible
    bind.dnsutils
    gitkraken
    heroku
    hugo
    jetbrains.pycharm-professional
    keybase-gui
    nixos-generators
    nixpkgs-fmt
  	nur.repos.yes.archlinux.paru
    nur.repos.yes.archlinux.asp
    nur.repos.yes.archlinux.devtools
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
        pkief.material-icon-theme
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

  # Import secrets needed for development
  sops.secrets."login/sops" = {
    mode = "0600";
    owner = config.users.users.nico.name;
    path = "/home/nico/.config/sops/age/keys.txt";
  };
  sops.secrets."api_keys/heroku" = {
    mode = "0600";
    owner = config.users.users.nico.name;
    path = "/home/nico/.netrc";
  };

  # Conflicts with virtualisation.containers if enabled
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
