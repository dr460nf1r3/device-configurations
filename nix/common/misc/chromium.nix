{ pkgs, ... }:
{
  # Command line settings
  environment.systemPackages = with pkgs; [ 
    (chromium.override {
      commandLineArgs = [
        "--enable-gpu-rasterization"
        "--enable-vulkan"
        "--enable-accelerated-2d-canvas"
        "--enable-features=VaapiVideoDecoder"
        "--enable-features=WebUIDarkMode"
        "--enable-gpu-rasterization"
        "--enable-zero-copy"
        "--ignore-gpu-blocklist"
        "--ozone-platform-hint=auto"
      ];
    })
   ];
  # Basic chromium settings
  programs.chromium = {
    defaultSearchProviderEnabled = true;
    defaultSearchProviderSearchURL = "https://search.dr460nf1r3.org/search?q=%s";
    defaultSearchProviderSuggestURL = "https://search.dr460nf1r3.org/autocomplete?q=%s";
    enable = true;
    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock origin
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
      "njdfdhgcmkocbgbhcioffdbicglldapd" # LocalCDN
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
      "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock
    ];
    extraOpts = {
      "HomepageLocation" = "https://search.dr460nf1r3.org";
      "QuicAllowed" = true;
      "RestoreOnStartup" = true;
      "ShowHomeButton" = true;
    };
  };

  # SUID Sandbox
  security.chromiumSuidSandbox.enable = true;
}
