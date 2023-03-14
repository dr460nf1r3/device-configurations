{ pkgs, lib, config, ... }:
{
  imports = [
    ./boot.nix
    ./hardening.nix
    ./locales.nix
    ./nix.nix
    ./shells.nix
    ./sops.nix
    ./theming.nix
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
    execWheelOnly = true;
    extraConfig = ''
      Defaults pwfeedback
      ansible ALL=(ALL) NOPASSWD:ALL
    '';
    package = pkgs.sudo.override { withInsults = true; };
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

  # Earlyoom for oom situations
  services.earlyoom = {
    enable = true;
    enableNotifications = true;
    freeMemThreshold = 5;
  };

  # Get notifications about earlyoom actions
  services.systembus-notify.enable = true;

  # Environment
  environment.Increase Mosh timeout
    variables = { MOSH_SERVER_NETWORK_TMOUT = "604800"; };
  };

  # Enable all the firmwares
  hardware.enableRedistributableFirmware = true;

  # Disable generation of manpages
  documentation.man.enable = false;
}
