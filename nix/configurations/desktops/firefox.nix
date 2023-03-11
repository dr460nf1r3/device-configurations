{ pkgs, home-manager, ... }:
{
  # Basic Firefox settings (user)
  home-manager.users.nico.programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      name = "Default";
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bypass-paywalls-clean
        darkreader
        enhanced-github
        flagfox
        grammarly
        gsconnect
        libredirect
        localcdn
        privacy-pass
        tabliss
        ublock-origin
      ];
      extraConfig = builtins.readFile "/etc/nixos/assets/firefox.cfg";
      isDefault = true;
      search.engines = {
        "Nix Packages" = {
          urls = [{
            template = "https://search.nixos.org/packages";
            params = [
              { name = "type"; value = "packages"; }
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@np" ];
        };
        "NixOS Wiki" = {
          urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
          iconUpdateURL = "https://nixos.wiki/favicon.png";
          updateInterval = 24 * 60 * 60 * 1000;
          definedAliases = [ "@nw" ];
        };
        "Whoogle" = {
          urls = [{ template = "https://search.dr460nf1r3.org?search={searchTerms}"; }];
          iconUpdateURL = "https://search.dr460nf1r3.org/favicon.png";
          updateInterval = 24 * 60 * 60 * 1000;
          definedAliases = [ "@w" ];
        };
        "Amazon.com".metaData.hidden = true;
        "Bing".metaData.hidden = true;
        "Google".metaData.hidden = true;
        "eBay".metaData.hidden = true;
      };
    };
  };

  # System-wide policies
  programs.firefox = {
    enable = true;
    policies = {
      CaptivePortal = false;
      DisableFirefoxAccounts = false;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      FirefoxHome = {
        Highlights = false;
        Pocket = false;
        Search = true;
        Snippets = false;
        TopSites = false;
      };
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      OfferToSaveLoginsDefault = false;
      PasswordManagerEnabled = false;
      UserMessaging = {
        ExtensionRecommendations = false;
        SkipOnboarding = true;
      };
    };
    nativeMessagingHosts.gsconnect = true;
  };

  # Enable Wayland
  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_USE_XINPUT2 = "1";
  };
}
