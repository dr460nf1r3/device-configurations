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
    "org/gnome/desktop/app-folders" = {
      folder-children = [ "Utilities" ];
    };
    "org/gnome/desktop/input-sources" = {
      sources = [ (lib.hm.gvariant.mkTuple [ "xkb" "de" ]) ];
      xkb-options = [ "terminate:ctrl_alt_bksp" ];
    };
    "org/gnome/desktop/notifications" = {
      application-children = [ "code-url-handler" "org-telegram-desktop" ];
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
      initial-size = lib.hm.gvariant.mkTuple [ 890 550 ];
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
      id = "a4f40bf4-47db-47b6-9fda-a4c71d9f2893";
      name = "Slim Nixed";
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
    "org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9" = {
      bold-is-bright = true;
      cursor-blink-mode = "on";
      cursor-shape = "ibeam";
      custom-command = "${pkgs.fish}/bin/fish";
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

  # Enhance audio output
  services.pulseeffects.enable = true;
}
