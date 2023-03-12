{ pkgs, config, lib, sops-nix, ... }:
{
  # This is the default sops file that will be used for all secrets
  sops.defaultSopsFile = ../../secrets/global.yaml;
  
  # https://github.com/Mic92/sops-nix/issues/149
  # Supply the keys /etc/ssh/ssh_host_{rsa,ed25519}_key to sops
  # via ZFS snapshot zroot/ROOT/empty@keys and rollback to this snapshot
  sops.age.keyFile = "/var/persistent/secrets/keys.txt";
}
