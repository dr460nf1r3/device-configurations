{ inputs, pkgs, ... }:
{
  # List the packages I need
  environment.systemPackages = with pkgs; [
    teams-for-linux
  ];

  # Sync my school stuff
  # services.onedrive.enable = true;
}
