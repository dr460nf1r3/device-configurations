{ pkgs, ... }: {
  # We want to use NetworkManager
  networking = {
    networkmanager = {
      dns = "systemd-resolved";
      enable = true;
      wifi.backend = "iwd";
    };
    # Disable non-NetworkManager
    useDHCP = false;
  };

  # Systemd-resolved using the local NextDNS
  services.resolved = {
    enable = true;
    extraConfig = "MulticastDNS=true";
    fallbackDns = [ "127.0.0.1" ];
  };

  # NextDNS configured for ad & tracking blocking
  services.nextdns = {
    arguments = [ "-config" "ab21b4" ];
    enable = true;
  };

  # Zerotier network to connect the devices
  networking.firewall.trustedInterfaces = [ "ztnfaljg5n" ];
  services.zerotierone = {
    enable = true;
    joinNetworks = [ "a84ac5c10a715aa7" ];
  };

  # Zerotier hosts for easy access
  networking.hosts = {
    "10.241.1.1" = [ "slim-lair" ];
    "10.241.1.2" = [ "tv-nixos" ];
  };
}
