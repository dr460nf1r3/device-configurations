{ pkgs, ... }:
{
  # Basic chromium settings (system-wide)
  programs.chromium = {
    defaultSearchProviderEnabled = true;
    defaultSearchProviderSearchURL = "https://search.dr460nf1r3.org/search?q=%s";
    defaultSearchProviderSuggestURL = "https://search.dr460nf1r3.org/autocomplete?q=%s";
    enable = true;
    extensions = [
      "ajhmfdgkijocedmfjonnpjfojldioehi" # Privacy Pass
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock origin
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
      "hipekcciheckooncpjeljhnekcoolahp" # Tabliss
      "jfnifeihccihocjbfcfhicmmgpjicaec" # GSConnect
      "kbfnbcaeplbcioakkpcpgfkobkghlhen" # Grammarly
      "mdjildafknihdffpkfmmpnpoiajfjnjd" # Consent-O-Matic
      "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock
      "njdfdhgcmkocbgbhcioffdbicglldapd" # LocalCDN
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
    ];
    extraOpts = {
      "HomepageLocation" = "https://search.dr460nf1r3.org";
      "QuicAllowed" = true;
      "RestoreOnStartup" = true;
      "ShowHomeButton" = true;
    };
  };

  # Basic Chromium settings using Ungoogled Chromium (user)
  home-manager.users.nico.programs.chromium = {
    enable = true;
    commandLineArgs = [
      "--enable-accelerated-2d-canvas"
      "--enable-features=VaapiVideoDecoder"
      "--enable-features=WebUIDarkMode"
      "--enable-gpu-rasterization"
      "--enable-vulkan"
      "--enable-zero-copy"
      "--ignore-gpu-blocklist"
      "--ozone-platform-hint=auto"
    ];
  };

  # SUID Sandbox
  security.chromiumSuidSandbox.enable = true;
}
