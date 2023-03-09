{ ... }: {
  # Programs & global config
  programs = {
    bash.shellAliases = {
      # General useful things & theming
      "bat" = "bat --style header --style snip --style changes";
      "cls" = "clear";
      "dd" = "dd progress=status";
      "dir" = "dir --color=auto";
      "egrep" = "egrep --color=auto";
      "fgrep" = "fgrep --color=auto";
      "gcommit" = "git commit -m";
      "gitlog" = "git log --oneline --graph --decorate --all";
      "glcone" = "git clone";
      "gpr" = "git pull --rebase";
      "gpull" = "git pull";
      "gpush" = "git push";
      "ip" = "ip --color=auto";
      "jctl" = "journalctl -p 3 -xb";
      "ls" = "exa -al --color=always --group-directories-first --icons";
      "micro" = "micro -colorscheme geany -autosu true -mkparents true";
      "psmem" = "ps auxf | sort -nr -k 4";
      "psmem10" = "ps auxf | sort -nr -k 4 | head -1";
      "su" = "sudo su -";
      "tarnow" = "tar acf ";
      "untar" = "tar zxvf ";
      "vdir" = "vdir --color=auto";
      "wget" = "wget -c";
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
    command-not-found.enable = false;
    fish = {
      enable = true;
      vendor = {
        config.enable = true;
        completions.enable = true;
      };
      shellAbbrs = {
        "cls" = "clear";
        "gcommit" = "git commit -m";
        "glcone" = "git clone";
        "gpr" = "git pull --rebase";
        "gpull" = "git pull";
        "gpush" = "git push";
        "reb" = "sudo nixos-rebuild switch -L";
        "roll" = "sudo nixos-rebuild switch --rollback";
        "su" = "sudo su -";
        "tarnow" = "tar acf ";
        "test" = "sudo nixos-rebuild switch --test";
        "untar" = "tar zxvf ";
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
      shellAliases = {
        "bat" = "bat --style header --style snip --style changes";
        "dd" = "dd progress=status";
        "dir" = "dir --color=auto";
        "egrep" = "egrep --color=auto";
        "fgrep" = "fgrep --color=auto";
        "gitlog" = "git log --oneline --graph --decorate --all";
        "ip" = "ip --color=auto";
        "jctl" = "journalctl -p 3 -xb";
        "ls" = "exa -al --color=always --group-directories-first --icons";
        "micro" = "micro -colorscheme geany -autosu true -mkparents true";
        "psmem" = "ps auxf | sort -nr -k 4";
        "psmem10" = "ps auxf | sort -nr -k 4 | head -1";
        "vdir" = "vdir --color=auto";
        "wget" = "wget -c";
      };
      shellInit = ''
        set fish_greeting
      '';
    };
  };
}
