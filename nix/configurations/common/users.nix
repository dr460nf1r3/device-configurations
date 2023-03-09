{ keys, lib, config, home-manager, ... }: {
  # All users are immuntable; if a password is required it needs to be set via passwordFile
  users.mutableUsers = false;
  # This is for easy configuration roll-out
  users.users.ansible = {
    extraGroups = [ "wheel" ];
    home = "/home/ansible";
    isNormalUser = true;
    openssh.authorizedKeys.keyFiles = [ keys.nico ];
    uid = 2000;
  };
  # Lock root password
  users.users.root = {
    passwordFile = "/var/persistent/secrets/pass/root";
  };
  # My user
  users.users.nico = {
    extraGroups = [
      "adbusers"
      "audio"
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
    passwordFile = "/var/persistent/secrets/pass/nico";
    uid = 1000;
  };

  # Load my home-manager configurations
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.nico = import ../home/nico.nix;
  };
}
