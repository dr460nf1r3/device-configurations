{ keys, lib, config, home-manager, ... }: {
  # All users are immuntable; if a password is required it needs to be set via passwordFile
  users.mutableUsers = true;

  # This is for easy configuration roll-out
  users.users.ansible = {
    extraGroups = [ "wheel" ];
    home = "/home/ansible";
    isNormalUser = true;
    openssh.authorizedKeys.keyFiles = [ keys.nico ];
    uid = 2000;
  };
  # My user
  users.users.nico = {
    extraGroups = [ "wheel" "docker" "networkmanager" "disk" "audio" "video" "systemd-journal" "adbusers" ];
    home = "/home/nico";
    isNormalUser = true;
    openssh.authorizedKeys.keyFiles = [ keys.nico ];
    passwordFile = "/var/dragons/secrets/pass/nico";
    uid = 1000;
  };

  # Load our home-manager configurations
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.nico = import ./home/nico.nix;
  };

}
