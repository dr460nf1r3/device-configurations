{ keys, lib, config, home-manager, ... }:
{
  # All users are immuntable; if a password is required it needs to be set via passwordFile
  users.mutableUsers = false;
  
  # This is needed for early set up of user accounts
  sops.secrets."passwords/nico" = {
    neededForUsers = true;
  };
  sops.secrets."passwords/root" = {
    neededForUsers = true;
  };

  # This is for easy configuration roll-out
  users.users.ansible = {
    extraGroups = [ "wheel" ];
    home = "/home/ansible";
    isNormalUser = true;
    openssh.authorizedKeys.keyFiles = [ keys.nico ];
    password = "*";
    uid = 2000;
  };
  # Lock root password
  users.users.root = {
    passwordFile = config.sops.secrets."passwords/root".path;
  };
  # My user
  users.users.nico = {
    extraGroups = [
      "adbusers"
      "audio"
      "chaotic_op"
      "disk"
      "docker"
      "networkmanager"
      "podman"
      "systemd-journal"
      "video"
      "wheel"
      "wireshark"
    ];
    home = "/home/nico";
    isNormalUser = true;
    openssh.authorizedKeys.keyFiles = [ keys.nico ];
    passwordFile = config.sops.secrets."passwords/nico".path;
    uid = 1000;
  };

  # Load my home-manager configurations
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.nico = import ../home/nico.nix;
  };
}
