{ config, pkgs, lib, ... }:

{
  # Always needed home-manager settings - don't touch!
  home.homeDirectory = "/home/nico";
  home.stateVersion = "22.11";
  home.username = "nico";

  # Personally used packages
  home.packages = with pkgs; [
    adwaita-qt
    gnomeExtensions.burn-my-windows
    gnomeExtensions.dash-to-dock
    gnomeExtensions.gsconnect
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.unite
    gnomeExtensions.user-themes
    gnomeExtensions.vitals
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
    "org/gnome/shell" = {
      disable-user-extensions = false;
      # To-be enabled extensions                                                                                        
      enabled-extensions = [
        "Vitals@CoreCoding.com"
        "trayIconsReloaded@selfmade.pl"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
      ];
    };
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