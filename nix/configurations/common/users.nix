{ keys, lib, config, home-manager, ... }:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
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
    password = builtins.readFile config.sops.secrets."passwords/root".path;
  };
  # My user
  users.users.nico = {
    extraGroups = [
      "audio"
      "systemd-journal"
      "video"
      "wheel"
    ] ++ ifTheyExist [
      "adbusers"
      "chaotic_op"
      "deluge"
      "disk"
      "docker"
      "git"
      "i2c"
      "libvirtd"
      "mysql"
      "network"
      "networkmanager"
      "podman"
      "wireshark"
    ];
    home = "/home/nico";
    isNormalUser = true;
    openssh.authorizedKeys.keyFiles = [ keys.nico ];
    password = builtins.readFile config.sops.secrets."passwords/nico".path;
    uid = 1000;
  };

  # Load my home-manager configurations
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.nico = import ../home/nico.nix;
  };

  # Increase open file limit for sudoers
  security.pam.loginLimits = [
    {
      domain = "@wheel";
      item = "nofile";
      type = "soft";
      value = "524288";
    }
    {
      domain = "@wheel";
      item = "nofile";
      type = "hard";
      value = "1048576";
    }
  ];
}
