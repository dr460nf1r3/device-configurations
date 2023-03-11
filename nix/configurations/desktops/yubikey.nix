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

  # List the packages I need
  environment.systemPackages = with pkgs; [
    yubikey-personalization
    yubioath-flutter
  ];

  # Enable the smartcard daemon to for signing
  home-manager.users.nico.services.gpg-agent = {
    enableExtraSocket = true;
    enableScDaemon = true;
  };

  # Login with Yubikey
  sops.secrets."login/yubikey" = {
    mode = "0600";
    owner = config.users.users.nico.name;
    path = "/home/nico/.yubico/challenge-18063966";
  };
}
