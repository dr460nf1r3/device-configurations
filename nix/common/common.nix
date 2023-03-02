{ pkgs, lib, config, sources, ... }: {
  imports = [ ./hardening.nix ./users.nix ];

  # Network stuff
  networking = {
    nameservers = [ "127.0.0.1" ];
    networkmanager = { wifi.backend = "iwd"; };
    usePredictableInterfaceNames = true;
    useHostResolvConf = true;
  };

  # NextDNS
  services.nextdns.enable = true;
  services.nextdns.arguments = [ "-config" "ab21b4" ];

  ## Enable BBR & cake
  boot.kernelModules = [ "tcp_bbr" ];
  boot.kernel.sysctl = {
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "cake";
  };
  boot.cleanTmpDir = true;

  # More modern stage 1 in boot
  boot.initrd.systemd.enable = true;

  # Locales & timezone
  time.timeZone = "Europe/Berlin";
  i18n = {
    extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
    defaultLocale = "en_US.UTF-8";
    supportedLocales =
      [ "en_GB.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" "de_DE.UTF-8/UTF-8" ];
  };

  # X11
  services.xserver = {
    layout = "de";
    xkbVariant = "";
  };
  # Console setup
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };

  # Home-manager configuration
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.nico = import ./home/nico.nix;
  };

  # We want to be insulted on wrong passwords
  security.sudo.package = pkgs.sudo.override { withInsults = true; };
  security.sudo.wheelNeedsPassword = false;

  # Programs & global config
  programs.mosh.enable = true;
  programs.command-not-found.enable = false;
  programs.bash.shellAliases = {
    "bat" = "bat --style header --style snip --style changes";
    "cls" = "clear";
    "dir" = "dir --color=auto";
    "egrep" = "egrep --color=auto";
    "fgrep" = "fgrep --color=auto";
    "ip" = "ip --color=auto";
    "ls" = "exa -al --color=always --group-directories-first --icons";
    "micro" = "micro -colorscheme geany -autosu true -mkparents true";
    "psmem" = "ps auxf | sort -nr -k 4";
    "psmem10" = "ps auxf | sort -nr -k 4 | head -1";
    "su" = "sudo su -";
    "tarnow" = "tar acf ";
    "untar" = "tar zxvf ";
    "vdir" = "vdir --color=auto";
    "wget" = "wget -c";
  };
  programs.fish = {
    enable = true;
    vendor = {
      config.enable = true;
      completions.enable = true;
    };
    shellAbbrs = {
      "cls" = "clear";
      "reb" = "sudo nixos-rebuild switch -L";
      "roll" = "sudo nixos-rebuild switch --rollback";
      "su" = "sudo su -";
    };
    shellAliases = {
      "bat" = "bat --style header --style snip --style changes";
      "dir" = "dir --color=auto";
      "egrep" = "egrep --color=auto";
      "fgrep" = "fgrep --color=auto";
      "ip" = "ip --color=auto";
      "ls" = "exa -al --color=always --group-directories-first --icons";
      "micro" = "micro -colorscheme geany -autosu true -mkparents true";
      "psmem" = "ps auxf | sort -nr -k 4";
      "psmem10" = "ps auxf | sort -nr -k 4 | head -1";
      "tarnow" = "tar acf ";
      "untar" = "tar zxvf ";
      "vdir" = "vdir --color=auto";
      "wget" = "wget -c";
    };
    shellInit = ''
      set fish_greeting
    '';
  };
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "tty";
  };
  programs.git = {
    enable = true;
    lfs.enable = true;
  };
  programs.ssh.package = pkgs.openssh_hpn;

  # Services 
  services = {
    vnstat.enable = true;
    openssh = {
      enable = true;
      startWhenNeeded = true;
    };
    locate = {
      enable = true;
      localuser = null;
      locate = pkgs.plocate;
    };
  };

  # Systemd-oomd daemon
  systemd.oomd = {
    enable = true;
    enableUserServices = true;
    extraConfig = { DefaultMemoryPressureDurationSec = "20s"; };
  };

  # Docker
  virtualisation.docker = {
    autoPrune.enable = true;
    autoPrune.flags = [ "-a" ];
    rootless.enable = true;
    storageDriver = "overlay2";
  };

  # Environment
  environment = {
    # Packages the system needs, individual user packages shall be put into home-manager configurations
    systemPackages = with pkgs; [
      btop
      exa
      jq
      killall
      micro
      python3
      ugrep
      wget
    ];
    # Increase Mosh timeout
    variables = { MOSH_SERVER_NETWORK_TMOUT = "604800"; };
  };

  # Store some system metrics
  services.netdata.enable = true;
  services.netdata.config = { ml = { "enabled" = "yes"; }; };

  # Extra Python & system packages required for Netdata to function
  services.netdata.python.extraPackages = ps: [ ps.psycopg2 ];
  systemd.services.netdata = { path = (with pkgs; [ jq ]); };

  # General nix settings
  nix = {
    # Do garbage collections whenever there is less than 1GB free space left
    extraOptions = ''
      min-free = ${toString (1024 * 1024 * 1024)}
    '';
    # Do daily garbage collections
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
    settings = {
      # Allow using flakes
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      trusted-users = [ "root" "nico" ];
      max-jobs = "auto";
    };
    nixPath = [ "nixpkgs=${sources.nixpkgs}" ];
  };

  # Our kernel parameters
  boot.kernel.sysctl = {
    "kernel.nmi_watchdog" = 0;
    "kernel.printks" = "3 3 3 3";
    "kernel.sched_cfs_bandwidth_slice_us" = 3000;
    "kernel.sysrq" = 1;
    "kernel.unprivileged_userns_clone" = 1;
    "net.core.rmem_max" = 2500000;
    "net.ipv4.tcp_fin_timeout" = 5;
    "vm.swappiness" = 133;
  };

  # Clean results periodically
  systemd.services.nix-clean-result = {
    serviceConfig.Type = "oneshot";
    description =
      "Auto clean all result symlinks created by nixos-rebuild test";
    script = ''
      "${config.nix.package.out}/bin/nix-store" --gc --print-roots | "${pkgs.gawk}/bin/awk" 'match($0, /^(.*\/result) -> \/nix\/store\/[^-]+-nixos-system/, a) { print a[1] }' | xargs -r -d\\n rm
    '';
    before = [ "nix-gc.service" ];
    wantedBy = [ "nix-gc.service" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable all the firmwares
  hardware.enableRedistributableFirmware = true;

  # Disable generation of manpages
  documentation.man.enable = false;

  # Print a diff when running system updates
  system.activationScripts.diff = ''
    if [[ -e /run/current-system ]]; then
      ${pkgs.nix}/bin/nix store diff-closures /run/current-system "$systemConfig"
    fi
  '';
}
