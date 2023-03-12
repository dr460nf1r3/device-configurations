{ pkgs, config, ... }:
{
  # Enable the smartcard daemon
  hardware.gpgSmartcards.enable = true;
  services.udev.packages = [ pkgs.yubikey-personalization ];
  services.pcscd.enable = true;

  # Configure as challenge-response for instant login
  security.pam.yubico = {
    debug = false;
    enable = true;
    mode = "challenge-response";
  };
  sops.secrets."misc/yubikey" = {
    mode = "0600";
    owner = config.users.users.nico.name;
    path = "/home/nico/.yubico/challenge-18063966";
  };

  # Yubikey personalization & Yubico Authenticator
  environment.systemPackages = with pkgs; [
    yubikey-personalization
    yubioath-flutter
  ];

  # Enable the smartcard daemon for commit signing
  home-manager.users.nico.services.gpg-agent = {
    enableExtraSocket = true;
    enableScDaemon = true;
  };
}
