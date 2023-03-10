{ pkgs, config, ... }:
{
  # Let me use my Yubikey as login
  hardware.gpgSmartcards.enable = true;
  services.udev.packages = [ pkgs.yubikey-personalization ];
  services.pcscd.enable = true;
  security.pam.yubico = {
    debug = false;
    enable = true;
    mode = "challenge-response";
  };
}
