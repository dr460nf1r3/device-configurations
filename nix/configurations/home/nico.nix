{ config, pkgs, lib, ... }:
{
  # Import individual configuration snippets
  imports = [
    ./gnome.nix
    ./misc.nix
    ./shells.nix
    ./theming.nix
  ];

  # Always needed home-manager settings - don't touch!
  home.homeDirectory = "/home/nico";
  home.stateVersion = "22.11";
  home.username = "nico";

  # I'm working with git a lot
  programs = {
    git = {
      enable = true;
      extraConfig = {
        core = { editor = "micro"; };
        init = { defaultBranch = "main"; };
        pull = { rebase = true; };
      };
      userEmail = "root@dr460nf1r3.org";
      userName = "Nico Jensch";
      signing = {
        key = "D245D484F3578CB17FD6DA6B67DB29BFF3C96757";
        signByDefault = true;
      };
    };
    gitui.enable = true;
  };

  # GPG for Yubikey
  services.gpg-agent = lib.mkIf config.hardware.gpgSmartcards.enable {
    enableExtraSocket = true;
    enableScDaemon = true;
  };

  # Alacritty, the terminal emulator
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = { family = "Jetbrains Mono"; };
        size = 11.0;
      };
      window.opacity = 0.9;
      shell = {
        program = "${pkgs.fish}/bin/fish";
        args = [ "--login" ];
      };
    };
  };
}
