{ lib, pkgs, ... }:
{
  # Enable dconf
  dconf.enable = true;
  # In case we use GNOME
  dconf.settings = {
    "com/github/wwmm/pulseeffects" = {
      use-dark-theme = true;
    };
    "org/gnome/calculator" = {
      accuracy = 5;
      angle-units = "degrees";
      base = 10;
      button-mode = "programming";
      number-format = "automatic";
      word-size = 64;
    };
    "org/gnome/calendar" = {
      active-view = "month";
      window-maximized = false;
      window-size = lib.hm.gvariant.mkTuple [ 768 600 ];
    };
    "org/gnome/Connections" = {
      first-run = false;
    };
    "org/gnome/desktop/app-folders" = {
      folder-children = [ "Utilities" ];
    };
    "org/gnome/desktop/input-sources" = {
      sources = [ (lib.hm.gvariant.mkTuple [ "xkb" "de" ]) ];
      xkb-options = [ "terminate:ctrl_alt_bksp" ];
    };
    "org/gnome/desktop/notifications" = {
      application-children = [ "code-url-handler" "org-telegram-desktop" "gnome-power-panel" "org-gnome-shell-extensions-gsconnect" "chromium-browser" ];
    };
    "org/gnome/desktop/notifications/application/code-url-handler" = {
      application-id = "code-url-handler.desktop";
    };
    "org/gnome/desktop/notifications/application/org-telegram-desktop" = {
      application-id = "org.telegram.desktop.desktop";
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
    };
    "org/gnome/desktop/privacy" = {
      recent-files-max-age = 30;
    };
    "org/gnome/desktop/screensaver" = {
      lock-delay = lib.hm.gvariant.mkUint32 120;
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "close,minimize:appmenu";
    };
    "org/gnome/evolution-data-server" = {
      migrated = true;
    };
    "org/gnome/gnome-system-monitor" = {
      graph-data-points = 140;
      maximized = false;
      network-total-in-bits = false;
      process-memory-in-iec = false;
      show-dependencies = true;
      show-whose-processes = "user";
      update-interval = 1000;
      window-state = lib.hm.gvariant.mkTuple [ 900 600 ];
    };
    "org/gnome/maps" = {
      last-viewed-location = [ 51.349622329439484 7.0764894345799405 ];
      map-type = "MapsStreetSource";
      osm-username-oauth2 = "dr460nf1r3";
      show-scale = false;
      transportation-type = "pedestrian";
      window-maximized = false;
      window-size = [ 1300 750 ];
      zoom-level = 8;
    };
    "org/gnome/mutter" = {
      attach-modal-dialogs = true;
      center-new-windows = true;
      dynamic-workspaces = true;
      edge-tiling = true;
      focus-change-on-pointer-rest = true;
      workspaces-only-on-primary = false;
    };
    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
      migrated-gtk-settings = true;
      search-filter-time-type = "last_modified";
      show-create-link = true;
      show-delete-permanently = true;
    };
    "org/gnome/nautilus/window-state" = {
      initial-size = lib.hm.gvariant.mkTuple [ 1300 750 ];
    };
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "expandable-notifications@kaan.g.inam.org"
        "gnomeExtensions.pano"
        "gsconnect@andyholmes.github.io"
        "unite@hardpixel.eu"
      ];
      favorite-apps = [
        "org.gnome.Terminal.desktop"
        "org.gnome.Nautilus.desktop"
        "chromium-browser.desktop"
        "org.telegram.desktop.desktop"
        "thunderbird.desktop"
        "com.spotify.Client.desktop"
        "gitkraken.desktop"
        "code.desktop"
      ];
    };
    "org/gnome/shell/extensions/gsconnect" = {
      devices = [ "c9b46110e36de16a" ];
      enabled = true;
      id = "a4f40bf4-47db-47b6-9fda-a4c71d9f2893";
      name = "Slim Nixed";
    };
    "org/gnome/shell/extensions/gsconnect/device/c9b46110e36de16a" = {
      certificate-pem = "-----BEGIN CERTIFICATE-----\nMIIC9zCCAd+gAwIBAgIBATANBgkqhkiG9w0BAQsFADA/MRkwFwYDVQQDDBBjOWI0\nNjExMGUzNmRlMTZhMRQwEgYDVQQLDAtLREUgQ29ubmVjdDEMMAoGA1UECgwDS0RF\nMB4XDTIxMTIzMTIzMDAwMFoXDTMxMTIzMTIzMDAwMFowPzEZMBcGA1UEAwwQYzli\nNDYxMTBlMzZkZTE2YTEUMBIGA1UECwwLS0RFIENvbm5lY3QxDDAKBgNVBAoMA0tE\nRTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMnPph3GhrOXIBrSry6i\nt3I7v9Jy51Cq3izAxh3VNaUCNjkDCCK02hYkKkbMlkixzEIWDGQhvj3nEGp/MWE5\no5A7eE+6n70dKwTa23pJpNy2Vw5B+Kzv6WEslt4XsPhavlC/hvEQRsGPFuW1H02m\nLshuwGT42wbtDVYoSjlETpOTmTHnhEVblXhUoScvYqBocPEVIG55lYXB6ghyyJMX\n/inI4cYdx2K+mirdOqNNNXUOHDkxX8SqBor8czgKGs6rETRC/WP/mUeY3Co+SwlS\nnTkq0VnB8G27VMOlyDd5vXePKxUS7XczaAsNv4D3G8d2S/Z+pDQAEXZF/3qqophT\nPFECAwEAATANBgkqhkiG9w0BAQsFAAOCAQEABX3p3gFU1uWa/oxBveAnBdxZAdTR\n/Z3EqJTKM8NQBgGgEZ4HPPPZF6le0/yqoaSU8Tdo8Q8atNrtKK7o9RWsOl3aG4MY\nIXTOorKqw6EaBZ4++GPTPwf8wgkwjmfgGvVKzYEaDxMsjvYgKhD3DKTmX2iHFuq8\njNZ+Twnv5clHFI7/4sqPmkEBSsS+sGAwgBwTVl4nTk+Rl7qwz485dmZ1tZQxqZaW\nLzKFpr2rDkBtSRyEr9uzyH/UkWaL2LeFkMqkZEgAtRURcorh0CTnO8mGpHFzyfqL\nZSgjp6Mw7RMXlvZAcoME6cdQPURJZhF99Xqz7wvzmC+mx6NnO+juq71IZg==\n-----END CERTIFICATE-----\n";
      incoming-capabilities = [ "kdeconnect.battery" "kdeconnect.battery.request" "kdeconnect.bigscreen.stt" "kdeconnect.clipboard" "kdeconnect.clipboard.connect" "kdeconnect.connectivity_report.request" "kdeconnect.contacts.request_all_uids_timestamps" "kdeconnect.contacts.request_vcards_by_uid" "kdeconnect.findmyphone.request" "kdeconnect.mousepad.keyboardstate" "kdeconnect.mousepad.request" "kdeconnect.mpris" "kdeconnect.mpris.request" "kdeconnect.notification" "kdeconnect.notification.action" "kdeconnect.notification.reply" "kdeconnect.notification.request" "kdeconnect.photo.request" "kdeconnect.ping" "kdeconnect.runcommand" "kdeconnect.sftp.request" "kdeconnect.share.request" "kdeconnect.share.request.update" "kdeconnect.sms.request" "kdeconnect.sms.request_attachment" "kdeconnect.sms.request_conversation" "kdeconnect.sms.request_conversations" "kdeconnect.systemvolume" "kdeconnect.telephony.request" "kdeconnect.telephony.request_mute" ];
      name = "Pixel 6";
      outgoing-capabilities = [ "kdeconnect.battery" "kdeconnect.battery.request" "kdeconnect.bigscreen.stt" "kdeconnect.clipboard" "kdeconnect.clipboard.connect" "kdeconnect.connectivity_report" "kdeconnect.contacts.response_uids_timestamps" "kdeconnect.contacts.response_vcards" "kdeconnect.findmyphone.request" "kdeconnect.mousepad.echo" "kdeconnect.mousepad.keyboardstate" "kdeconnect.mousepad.request" "kdeconnect.mpris" "kdeconnect.mpris.request" "kdeconnect.notification" "kdeconnect.notification.request" "kdeconnect.photo" "kdeconnect.ping" "kdeconnect.presenter" "kdeconnect.runcommand.request" "kdeconnect.sftp" "kdeconnect.share.request" "kdeconnect.sms.attachment_file" "kdeconnect.sms.messages" "kdeconnect.systemvolume.request" "kdeconnect.telephony" ];
      paired = true;
      supported-plugins = [ "battery" "clipboard" "connectivity_report" "contacts" "findmyphone" "mousepad" "mpris" "notification" "photo" "ping" "presenter" "runcommand" "sftp" "share" "sms" "systemvolume" "telephony" ];
      type = "phone";
    };
    "org/gnome/shell/extensions/gsconnect/device/c9b46110e36de16a/plugin/battery" = {
      custom-battery-notification = true;
      custom-battery-notification-value = lib.hm.gvariant.mkUint32 85;
      full-battery-notification = true;
    };
    "org/gnome/shell/extensions/gsconnect/device/c9b46110e36de16a/plugin/clipboard" = {
      receive-content = true;
      send-content = true;
    };
    "org/gnome/shell/extensions/gsconnect/device/c9b46110e36de16a/plugin/telephony" = {
      ringing-pause = true;
    };
    "org/gnome/shell/extensions/gsconnect/preferences" = {
      window-size = lib.hm.gvariant.mkTuple [ 640 440 ];
    };
    "org/gnome/shell/extensions/unite" = {
      desktop-name-text = "Nixed GNOME 🔥";
      greyscale-tray-icons = true;
      hideActivitiesButton = 1;
      notificationsPosition = 2;
      show-window-buttons = "never";
      window-buttons-theme = "adwaita";
      windowStates = 0;
    };
    "org/gnome/shell/weather" = {
      automatic-location = true;
      locations = "[<(uint32 2, <('Cologne / Bonn', 'EDDK', false, [(0.88779081866554632, 0.12508193554402447)], @a(dd) [])>)>]";
    };
    "org/gnome/software" = {
      first-run = false;
    };
    "org/gnome/system/location" = {
      enabled = true;
    };
    "org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9" = {
      bold-is-bright = true;
      cursor-blink-mode = "on";
      cursor-shape = "ibeam";
      custom-command = "${pkgs.fish}/bin/fish";
      default-size-columns = 120;
      default-size-rows = 30;
      font = "JetBrains Mono Nerd Font 12";
      login-shell = false;
      use-custom-command = true;
      use-system-font = false;
      visible-name = "Nico";
    };
    "org/gtk/gtk4/settings/file-chooser" = {
      show-hidden = true;
      sort-directories-first = true;
    };
    "system/locale" = {
      region = "de_DE.UTF-8";
    };
  };

  # Set Nautilus bookmarks & GDM user icon
  home.file = {
    ".config/gtk-3.0/bookmarks".text = ''
      file:///home/nico/Documents/browser FireDragon
      file:///home/nico/Documents/chaotic Chaotic-AUR
      file:///home/nico/Documents/garuda Garuda Linux
      file:///home/nico/Documents/misc Misc things
      file:///home/nico/Documents/school School stuff
      file:///home/nico/Documents/work Working area
    '';
    ".face".source = ../../assets/.face;
  };

  # Enhance audio output
  services.pulseeffects.enable = true;
}
