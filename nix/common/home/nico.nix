{ config, pkgs, lib, ... }:

{
  # Always needed home-manager settings - don't touch!
  home.username = "nico";
  home.homeDirectory = "/home/nico";
  home.stateVersion = "22.11";

  # Personally used packages
  home.packages = with pkgs; [
    nmap
    nettools
    bind
    whois
    traceroute
    lynis
    gnomeExtensions.user-themes
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.vitals
    adwaita-qt
    gnomeExtensions.dash-to-panel
    gnomeExtensions.burn-my-windows
    gnomeExtensions.unite
    gnomeExtensions.sound-output-device-chooser
    gnomeExtensions.space-bar
    palenight-theme
    gnomeExtensions.dash-to-dock
    gnomeExtensions.gsconnect
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
  dconf.enable = true;
  dconf.settings = {
    # ...                                                                                                                               
    "org/gnome/shell" = {
      disable-user-extensions = false;

      # `gnome-extensions list` for a list                                                                                              
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "trayIconsReloaded@selfmade.pl"
        "Vitals@CoreCoding.com"
        "dash-to-panel@jderose9.github.com"
        "sound-output-device-chooser@kgshank.net"
        "space-bar@luchrioh"
      ];
    };
    "org/gnome/desktop/interface" = { gtk-theme = "Adwaita-dark"; };
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1                                                                                             
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1                                                                                             
      '';
    };
  };

  programs.chromium.commandLineArgs = [
    "--ignore-gpu-blocklist"
    "--enable-gpu-rasterization"
    "--enable-zero-copy"
    "--enable-features=VaapiVideoDecoder"
    "--ignore-gpu-blocklist"
    "--ozone-platform-hint=auto"
    "--force-dark-mode"
    "--enable-features=WebUIDarkMode"
  ];
  programs.chromium.extensions =
    [{ id = "cjpalhdlnbpafiamejdnhcphjbkeiagm "; }];

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

    # Make sure we're using the english ones.
    userDirs = {
      enable = true;
      desktop = "$HOME/Desktop";
      documents = "$HOME/Documents";
      download = "$HOME/Downloads";
      pictures = "$HOME/Pictures";
      publicShare = "$HOME/Public";
      templates = "$HOME/Templates";
      videos = "$HOME/Videos";
      music = "$HOME/Music";
    };
  };

  programs.mpv = {
    enable = true;
    # For watching animes in 60fps
    package = pkgs.wrapMpv
      (pkgs.mpv-unwrapped.override { vapoursynthSupport = true; }) {
        # thanks @thiagokokada
        extraMakeWrapperArgs = [
          "--prefix"
          "LD_LIBRARY_PATH"
          ":"
          "${pkgs.vapoursynth-mvtools}/lib/vapoursynth"
        ];
      };
    config = {
      # Temporary & lossless screenshots
      screenshot-format = "png";
      screenshot-directory = "/tmp";
      # for Pipewire (Let's pray for MPV native solution)
      ao = "openal";
      # I don't usually plug my PC in a home-theater
      audio-channels = "stereo";

      # So dual-audio anime don't go crazy;
      alang = "jpn,eng";
      slang = "eng";

      # GPU & Wayland
      hwdec = "vaapi";
      vo = "gpu";
      gpu-context = "waylandvk";
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
      font_size = 17;
      fps_limit = 60;
      gl_vsync = 0;
      gpu_temp = true;
      io_read = true;
      io_write = true;
      position = "top-right";
      round_corners = 8;
      vram = true;
      vsync = 1;
      vulkan_driver = true;
      gpu_name = true;
      engine_version = true;
      width = 260;
      wine = true;
    };
  };

}
