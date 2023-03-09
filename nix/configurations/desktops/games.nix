{ inputs, pkgs, ... }:
{
  # Gaming packages
  environment.systemPackages = with pkgs; [
    lutris
    mangohud
    prismlauncher
    wine-staging
    winetricks
  ];

  # Enable gamemode
  programs.gamemode.enable = true;

  # Enable Steam
  programs.steam.enable = true;
  
  # Fix League of Legends
  boot.kernel.sysctl = {
    "abi.vsyscall32" = 0;
  };

}