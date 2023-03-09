{ pkgs, config, ... }:
{
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
