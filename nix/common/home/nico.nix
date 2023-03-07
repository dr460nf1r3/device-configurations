{ config, pkgs, lib, ... }:

{
  # Always needed home-manager settings - don't touch!
  home.homeDirectory = "/home/nico";
  home.stateVersion = "22.11";
  home.username = "nico";

  # Personally used packages
  home.packages = with pkgs; [
    gnomeExtensions.burn-my-windows
    gnomeExtensions.space-bar
    gnomeExtensions.username-and-hostname-to-panel
    gnomeExtensions.useless-gaps
    gnomeExtensions.unite
    gnomeExtensions.transparent-window-moving
    gnomeExtensions.toggle-alacritty
    gnomeExtensions.syncthing-indicator
    gnomeExtensions.spotify-tray
    gnomeExtensions.rounded-window-corners
    gnomeExtensions.rounded-corners
    gnomeExtensions.remove-alttab-delay-v2
    gnomeExtensions.project-manager-for-vscode
    gnomeExtensions.ideapad-mode
    gnomeExtensions.gsconnect
    gnomeExtensions.gnome-clipboard
    gnomeExtensions.github-notifications
    gnomeExtensions.gitlab-extension
    gnomeExtensions.expandable-notifications
    gnomeExtensions.dash2dock-lite
    gnomeExtensions.desktop-cube
    gnomeExtensions.compiz-windows-effect
    gnomeExtensions.bubblemail
    gnomeExtensions.blur-my-shell
    gnomeExtensions.arcmenu
  ];

  # Application user configuration
  programs = {
    bash = {
      enable = true;
      initExtra = ''
        if [ "$SSH_CLIENT" != "" ]; then
          exec tmux
        fi
      '';
    };
    bat = {
      enable = true;
      config = { theme = "GitHub"; };
    };
    btop = {
      enable = true;
      settings = {
        color_theme = "TTY";
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
    };
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
  services.pulseeffects = {
    enable = true;
  };
  # Icon themes
  gtk = {
    enable = true;
    iconTheme = {
      name = "Tela-circle-dark";
      package = pkgs.tela-circle-icon-theme;
    };
  };
  home.pointerCursor =
    {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };
  # Enable dconf
  dconf.enable = true;
  # In case we use GNOME
  dconf.settings = {
    "org/gnome/desktop/interface" = { color-scheme = "prefer-dark"; };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        #"user-theme@gnome-shell-extensions.gcampax.github.com"
        "gsconnect@andyholmes.github.io"
        #"dash-to-dock@micxgx.gmail.com"
        #"desktop-cube@schneegans.github.com"
        "unite@hardpixel.eu"
        #"github.notifications@alexandre.dufournet.gmail.com"
        #"expandable-notifications@kaan.g.inam.org"
        #"gnome-clipboard@b00f.github.i"
        #"rounded-window-corners@yilozt.shell-extension"
        #"projectmanagerforvscode@ahmafi.ir"
        "toggle-alacritty@itstime.tech"
        "blur-my-shell@aunetx"
        #"dash2dock-lite@icedman.github.com"
        "useless-gaps@pimsnel.com"
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
    # Configure blur-my-shell
    "org/gnome/shell/extensions/blur-my-shell" = {
      brightness = 0.85;
      dash-opacity = 0.25;
      sigma = 15; # Sigma means blur amount
      static-blur = true;
    };
    "org/gtk/gtk4/settings/file-chooser" = { show-hidden = true; };
    "org/gnome/shell/extensions/blur-my-shell/panel".blur = false;
    "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
      blur = true;
      style-dialogs = 0;
    };
    "org/gnome/settings-daemon/plugins/color" = { night-light-enabled = true; };
    "com/github/wwmm/pulseeffects" = { use-dark-theme = true; };
    "org/gnome/desktop/interface" = { font-name = "Fira Sans 10"; };
    "org/gnome/desktop/interface/font-name/org/gnome/desktop/interface" = { document-font-name = "Fira Sans 11"; };
    "org/gnome/desktop/interface" = { monospace-font-name = "JetBrains Mono 10"; };
    "org/gnome/desktop/peripherals/touchpad" = { tap-to-click = true; };
    "org/gnome/desktop/privacy" = { recent-files-max-age = 30; };
    "org/gnome/desktop/screensaver" = { lock-delay = "uint32 120"; };
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
      custom-battery-notification-value = "uint32 85";
    };
    "org/gnome/shell/extensions/gsconnect/device/c9b46110e36de16a/plugin/telephony" = { ringing-pause = true; };
  };

  # Configure Chromium for hardware acceleration & dark mode
  programs.chromium.commandLineArgs = [
    "--enable-features=VaapiVideoDecoder"
    "--enable-features=WebUIDarkMode"
    "--enable-gpu-rasterization"
    "--enable-zero-copy"
    "--force-dark-mode"
    "--ignore-gpu-blocklist"
    "--ignore-gpu-blocklist"
    "--ozone-platform-hint=auto"
  ];
  programs.dircolors.enable = true;

  # Files that I prefer to just specify
  home.file = {
    # I Don't really use bash, so I don't want its history...
    ".bashrc".text = ''
      unset HISTFILE
    '';
    # Don't forget to always load my .profile
    ".bash_profile".text = ''
      [[ -f ~/.bashrc ]] && . ~/.bashrc
      [[ -f ~/.profile ]] && . ~/.profile
    '';
    # I use autologin and forever in love with tmux sessions.
    ".profile".text = ''
      if [ -z "$TMUX" ] &&  [ "$SSH_CLIENT" != "" ]; then
        exec ${pkgs.fish}/bin/tmux"
    '';
    # `programs.tmux` looks bloatware nearby this simplist config,
    ".tmux.conf".text = ''
      set-option -g default-shell "${pkgs.fish}/bin/fish"
      # Full color range
      set-option -ga terminal-overrides ",*256col*:Tc,alacritty:Tc"
      # Expect mouse
      set -g mouse off
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
}
