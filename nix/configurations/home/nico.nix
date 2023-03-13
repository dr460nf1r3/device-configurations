{ config, pkgs, lib, ... }:
# let
#   spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
# in

{
  # Import individual configuration snippets
  imports = [
    ./shells.nix
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

  # Spicetify - this is currently giving an infinite recursion error
  # programs.spicetify =
  #   {
  #     enable = true;
  #     theme = spicePkgs.themes.catppuccin-mocha;
  #     colorScheme = "flamingo";
  #     enabledExtensions = with spicePkgs.extensions; [
  #       fullAppDisplay
  #     ];
  #   };
}
