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

  # Login with Yubikey - once we have secrets management
  # home.file = {
  #   ".yubico/challenge-18063966" = {
  #     mode = "600";
  #     text = ''
  #     '';
  #   };
  # };
}
