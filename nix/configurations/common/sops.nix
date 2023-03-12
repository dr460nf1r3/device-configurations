{ pkgs, config, lib, sops-nix, ... }:
{
  # This is the default sops file that will be used for all secrets
  sops.defaultSopsFile = ../../secrets/global.yaml;

  # This will automatically import SSH keys as age keys
  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
}
