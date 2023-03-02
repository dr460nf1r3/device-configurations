{ config, pkgs, lib, ... }:

{
  # Always needed home-manager settings - don't touch!
  home.username = "nico";
  home.homeDirectory = "/home/nico";
  home.stateVersion = "22.11";

  # Personally used packages
  home.packages = with pkgs; [ nmap nettools bind whois traceroute lynis ];

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
}
