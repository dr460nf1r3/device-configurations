{ pkgs, config, ... }:
{
  # Use bleeding edge mesa - to do
  # imports = /etc/nixos/pkgs/mesa.nix;

  # Automatically tune nice levels
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
  };

  # 90% ZRAM as swap
  zramSwap = {
    enable = true;
    memoryPercent = 90;
  };
}
