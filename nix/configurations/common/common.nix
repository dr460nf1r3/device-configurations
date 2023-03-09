{ pkgs, lib, config, ... }: {
  imports = [
    ./boot.nix
    ./hardening.nix
    ./locales.nix
    ./nix.nix
    ./shells.nix
    ./users.nix
    ../../overlays/default.nix
  ];

  ## Enable BBR & cake
  boot.kernelModules = [ "tcp_bbr" ];
  boot.kernel.sysctl = {
    "kernel.nmi_watchdog" = 0;
    "kernel.printks" = "3 3 3 3";
    "kernel.sched_cfs_bandwidth_slice_us" = 3000;
    "kernel.sysrq" = 1;
    "kernel.unprivileged_userns_clone" = 1;
    "net.core.default_qdisc" = "cake";
    "net.core.rmem_max" = 2500000;
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.ipv4.tcp_fin_timeout" = 5;
    "vm.swappiness" = 133;
  };

  # We want to be insulted on wrong passwords
  security.sudo = {
    extraConfig = ''
      Defaults pwfeedback
    '';
    package = pkgs.sudo.override { withInsults = true; };
    wheelNeedsPassword = false;
  };

  # Programs I always need
  programs = {
    git = {
      enable = true;
      lfs.enable = true;
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryFlavor = "tty";
    };
    # Better for mobile device SSH
    mosh.enable = true;
    # Use the performant openssh
    ssh = {
      package = pkgs.openssh_hpn;
    };
  };

  # Always needed services
  services = {
    locate = {
      enable = true;
      localuser = null;
      locate = pkgs.plocate;
    };
    openssh = {
      enable = true;
      startWhenNeeded = true;
    };
    vnstat.enable = true;
  };

  # Systemd-oomd daemon
  systemd.oomd = {
    enable = true;
    enableUserServices = true;
    extraConfig = { DefaultMemoryPressureDurationSec = "20s"; };
  };

  # Environment
  environment = {
    # Packages I always need
    systemPackages = with pkgs; [
      bind
      bitwarden-cli
      btop
      cached-nix-shell
      cachix
      curl
      dconf2nix
      direnv
      duf
      exa
      jq
      killall
      micro
      nettools
      nmap
      python3
      tldr
      traceroute
      ugrep
      wget
      whois
    ];
    # Increase Mosh timeout
    variables = { MOSH_SERVER_NETWORK_TMOUT = "604800"; };
  };

  # Enable all the firmwares
  hardware.enableRedistributableFirmware = true;

  # Disable generation of manpages
  documentation.man.enable = false;
}
