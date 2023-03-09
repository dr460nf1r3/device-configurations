{ config, pkgs, lib, ... }:
{
  # Always needed home-manager settings - don't touch!
  home.homeDirectory = "/home/nico";
  home.stateVersion = "22.11";
  home.username = "nico";

  # Application user configuration
  programs = {
    bash = {
      enable = true;
      initExtra = ''
        if [ -z "$TMUX" ] &&  [ "$SSH_CLIENT" != "" ]; then
          exec ${pkgs.fish}/bin/tmux
        fi
      '';
      shellAliases = {
        # Shortcuts for SSH
        "b" = "ssh -p 666 nico@65.108.140.36";
        "b2" = "ssh -p 4200 nico@89.58.13.188";
        "c" = "ssh -p 420";
        "e" = "ssh nico@89.58.13.188";
        "g1" = "ssh -p 222 nico@65.108.140.36";
        "g2" = "ssh -p 226 nico@65.108.140.36";
        "g3" = "ssh -p 223 nico@65.108.140.36";
        "g4" = "ssh -p 224  nico@65.108.140.36";
        "g5" = "ssh -p 225  nico@65.108.140.36";
        "g6" = "ssh -p 226 nico@65.108.140.36";
        "g7" = "ssh -p 227  nico@65.108.140.36";
        "m" = "ssh -p 6969 nico@65.108.140.36";
        "o" = "ssh nico@130.61.136.14";
        "w" = "ssh -p 6666 nico@65.108.140.36";
      };
    };
    bat = {
      enable = true;
      config = { theme = "gruvbox-dark"; };
    };
    btop = {
      enable = true;
      settings = {
        color_theme = "gruvbox-dark";
        proc_tree = true;
        theme_background = false;
      };
    };
    exa = {
      enable = true;
      enableAliases = true;
    };
    fish = {
      enable = true;
      shellAbbrs = {
        # Shortcuts for SSH
        "b" = "ssh -p 666 nico@65.108.140.36";
        "b2" = "ssh -p 4200 nico@89.58.13.188";
        "c" = "ssh -p 420";
        "e" = "ssh nico@89.58.13.188";
        "g1" = "ssh -p 222 nico@65.108.140.36";
        "g2" = "ssh -p 226 nico@65.108.140.36";
        "g3" = "ssh -p 223 nico@65.108.140.36";
        "g4" = "ssh -p 224  nico@65.108.140.36";
        "g5" = "ssh -p 225  nico@65.108.140.36";
        "g6" = "ssh -p 226 nico@65.108.140.36";
        "g7" = "ssh -p 227  nico@65.108.140.36";
        "m" = "ssh -p 6969 nico@65.108.140.36";
        "o" = "ssh nico@130.61.136.14";
        "w" = "ssh -p 6666 nico@65.108.140.36";
      };
      shellInit = ''
        # Functions to allow repeating previous command with !!
        function __history_previous_command
          switch (commandline -t)
          case "!"
            commandline -t $history[1]; commandline -f repaint
          case "*"
            commandline -i !
          end
        end
        function _history_previous_command_arguments
          switch (commandline -t)
          case "!"
            commandline -t ""
            commandline -f history-token-search-backward
          case "*"
            commandline -i '$'
          end
        end

        # Actually bind the keys
        bind ! __history_previous_command
        bind '$' __history_previous_command_arguments

        # Fish command history
        function history
          builtin history --show-time='%F %T '
        end
      '';
    };
    git = {
      enable = true;
      extraConfig = {
        core = { editor = "micro"; };
        init = { defaultBranch = "main"; };
        pull = { rebase = true; };
      };
      userEmail = "root@dr460nf1r3.org";
      userName = "Nico Jensch";
      signing = {
        key = "D245D484F3578CB17FD6DA6B67DB29BFF3C96757";
        signByDefault = true;
      };
    };
    gitui.enable = true;
    starship = {
      enable = true;
      settings = {
        username = {
          format = " [$user]($style)@";
          show_always = true;
          style_root = "bold red";
          style_user = "bold red";
        };
        hostname = {
          disabled = false;
          format = "[$hostname]($style) in ";
          ssh_only = false;
          style = "bold dimmed red";
          trim_at = "-";
        };
        scan_timeout = 10;
        directory = {
          style = "purple";
          truncate_to_repo = true;
          truncation_length = 0;
          truncation_symbol = "repo: ";
        };
        status = {
          disabled = false;
          map_symbol = true;
        };
        sudo = { disabled = false; };
        cmd_duration = {
          disabled = false;
          format = "took [$duration]($style)";
          min_time = 1;
        };
      };
    };
    tmux = {
      baseIndex = 1;
      clock24 = true;
      enable = true;
      extraConfig = ''
        set-option -ga terminal-overrides ",*256col*:Tc,alacritty:Tc"
      '';
      historyLimit = 10000;
      newSession = true;
      sensibleOnTop = false;
      shell = "${pkgs.fish}/bin/fish";
    };
  };
  # Enhance audio output
  services.pulseeffects = {
    enable = true;
  };
  # GPG for Yubikey
  services.gpg-agent.enableExtraSocket = true;
  services.gpg-agent.enableScDaemon = true;
  # Icon themes
  gtk = {
    enable = true;
    iconTheme = {
      name = "oomox-gruvbox-dark";
      package = pkgs.gruvbox-dark-icons-gtk;
    };
  };
  # Configure Qt theming
  qt = {
    enable = true;
    style.name = "adwaita-dark";
    platformTheme = "gtk";
  };
  # Our cursor theme
  home.pointerCursor =
    {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
      size = 32;
      gtk.enable = true;
    };
  # Enable dconf
  dconf.enable = true;
  # In case we use GNOME
  dconf.settings = {
    "org/gnome/desktop/interface" = { color-scheme = "prefer-dark"; };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "gsconnect@andyholmes.github.io"
        "dash-to-dock@micxgx.gmail.com"
        "unite@hardpixel.eu"
        "expandable-notifications@kaan.g.inam.org"
        "rounded-window-corners@yilozt.shell-extension"
        "gnomeExtensions.pano"
        #"projectmanagerforvscode@ahmafi.ir"
        #"toggle-alacritty@itstime.tech"
        #"blur-my-shell@aunetx"
        #"sp-tray@sp-tray.esenliyim.github.com"
      ];
      favorite-apps = [
        "Alacritty.desktop"
        "org.gnome.Nautilus.desktop"
        "chromium-browser.desktop"
        "code.desktop"
        "org.telegram.desktop.desktop"
        "spotify.desktop"
        "thunderbird.desktop"
      ];
    };
    "org/gtk/gtk4/settings/file-chooser".show-hidden = true;
    "org/gnome/shell/extensions/unite" = {
      desktop-name-text = "Nixed GNOME";
      greyscale-tray-icons = true;
      hideActivitiesButton = 1;
      notificationsPosition = 2;
      window-buttons-theme = "Adwaita";
      windowStates = 2;
    };
    "org/gnome/shell/extensions/dash-to-dock" = {
      transparency-mode = 3;
      running-indicator-style = 4;
      show-trash = false;

    };
    "com/github/wwmm/pulseeffects" = { use-dark-theme = true; };
    "org/gnome/calculator" = { button-mode = "programming"; };
    "org/gnome/desktop/interface" = { font-name = "Fira Sans 10"; };
    "org/gnome/desktop/interface" = { monospace-font-name = "JetBrains Mono 10"; };
    "org/gnome/desktop/interface/font-name/org/gnome/desktop/interface" = { document-font-name = "Fira Sans 11"; };
    "org/gnome/desktop/peripherals/touchpad" = { tap-to-click = true; };
    "org/gnome/desktop/privacy" = { recent-files-max-age = 30; };
    "org/gnome/desktop/screensaver" = { lock-delay = lib.hm.gvariant.mkUint32 120; };
    "org/gnome/desktop/wm/preferences" = { button-layout = "close,minimize:appmenu"; };
    "org/gnome/desktop/wm/preferences" = { titlebar-font = "Fira Sans Bold 11"; };
    "org/gnome/mutter" = { center-new-windows = true; };
    "org/gnome/mutter" = { workspaces-only-on-primary = false; };
    "org/gnome/nautilus/preferences" = { show-create-link = true; };
    "org/gnome/nautilus/preferences" = { show-delete-permanently = true; };
    "org/gnome/settings-daemon/plugins/power" = { sleep-inactive-ac-type = "nothing"; };
    "org/gtk/gtk4/settings/file-chooser" = { sort-directories-first = true; };
    "system/locale" = { region = "de_DE.UTF-8"; };
    "org/gnome/shell/extensions/gsconnect/device/c9b46110e36de16a/plugin/clipboard" = {
      send-content = true;
      receive-content = true;
    };
    "org/gnome/shell/extensions/gsconnect/device/c9b46110e36de16a/plugin/battery" = {
      full-battery-notification = true;
      custom-battery-notification = true;
      custom-battery-notification-value = lib.hm.gvariant.mkUint32 85;
    };
    "org/gnome/shell/extensions/gsconnect/device/c9b46110e36de16a/plugin/telephony" = { ringing-pause = true; };
  };

  # Enable dircolors
  programs.dircolors.enable = true;

  # Files that I prefer to just specify
  home.file = {
    # Don't forget to always load my .profile
    ".bash_profile".text = ''
      [[ -f ~/.bashrc ]] && . ~/.bashrc
      [[ -f ~/.profile ]] && . ~/.profile
    '';
  };
  programs.mpv = {
    enable = true;
    config = {
      # Temporary & lossless screenshots
      screenshot-format = "png";
      screenshot-directory = "/tmp";
      # for Pipewire (Let's pray for MPV native solution)
      ao = "openal";
      # I don't usually plug my PC in a home-theater
      audio-channels = "stereo";
      # GPU & Wayland
      hwdec = "vaapi";
      vo = "gpu";
      gpu-api = "vulkan";
      # YouTube quality
      ytdl-format = "bestvideo[height<=?2160]+bestaudio/best";
    };
  };
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = { family = "Jetbrains Mono"; };
        size = 11.0;
      };
      window.opacity = 0.9;
      shell = {
        program = "${pkgs.fish}/bin/fish";
        args = [ "--login" ];
      };
    };
  };
  programs.mangohud = {
    enable = true;
    settings = {
      arch = true;
      background_alpha = "0.05";
      battery = true;
      cpu_temp = true;
      engine_version = true;
      font_size = 17;
      fps_limit = 60;
      gl_vsync = 0;
      gpu_name = true;
      gpu_temp = true;
      io_read = true;
      io_write = true;
      position = "top-right";
      round_corners = 8;
      vram = true;
      vsync = 1;
      vulkan_driver = true;
      width = 260;
      wine = true;
    };
  };
  # Fix ugly missing desktop icon
  xdg.desktopEntries."btop++" = {
    name = "btop";
    exec = "btop";
    icon = "utilities-system-monitor";
    comment = "A cross-platform graphical process/system monitor";
    genericName = "System Monitor";
    categories = [ "System" "Utility" ];
    terminal = true;
    type = "Application";
  };
}
