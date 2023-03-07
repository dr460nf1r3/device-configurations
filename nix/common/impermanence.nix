# ZFS-based impermanence but instead of rolling back on every start, roll back on safe shutdown/halt/reboot
{ config, lib, pkgs, ... }: 
let
  cfgZfs = config.boot.zfs;
in
{
  # Reset rootfs
  systemd.shutdownRamfs.contents."/etc/systemd/system-shutdown/zpool".source =
    lib.mkForce
      (pkgs.writeShellScript "zpool-sync-shutdown" ''
        ${cfgZfs.package}/bin/zfs rollback -r zroot/ROOT/empty@start
        exec ${cfgZfs.package}/bin/zpool sync
      '');

  # Declare permanent path's
  systemd.shutdownRamfs.storePaths = [ "${cfgZfs.package}/bin/zfs" ];
  # Persistent files
  environment.persistence."/var/persistent" = {
    hideMounts = true;
    directories = [
      "/etc/NetworkManager/system-connections"
      "/etc/nixos"
      "/etc/ssh"
      "/var/lib/bluetooth"
      "/var/lib/containers"
      "/var/lib/flatpak"
      "/var/lib/systemd"
      "/var/lib/upower"
      { directory = "/var/lib/iwd"; mode = "u=rwx,g=,o="; }
    ];
    files = [
      "/etc/machine-id"
    ];
    users.root = {
      home = "/root";
      directories = [
        ".android" # adb keys
        { directory = ".gnupg"; mode = "0700"; }
        { directory = ".ssh"; mode = "0700"; }
      ];
    };
    users.nico = {
      directories = [
        ".android" # adb keys
        ".ansible"
        ".config/asciinema"
        ".config/chromium"
        ".config/Code"
        ".config/discord"
        ".config/evolution"
        ".config/GitKraken"
        ".config/goa-1.0"
        ".config/gsconnect"
        ".config/Nextcloud"
        ".config/obs-studio"
        ".config/PulseEffects"
        ".config/spotify"
        ".config/Termius"
        ".config/VirtualBox"
        ".gitkraken"
        ".local/share/containers"
        ".local/share/fish"
        ".local/share/heroku"
        { directory = ".local/share/keyrings"; mode = "0700"; }
        ".local/share/nautilus"
        ".local/share/Nextcloud"
        ".local/share/Steam"
        ".local/share/TelegramDesktop"
        ".local/share/tor-browser"
        ".local/share/Vorta"
        ".local/share/waydroid"
        ".mozilla"
        ".thunderbird"
        ".vmware"
        ".zoom"
        "Documents"
        "Downloads"
        "Music"
        "Nextcloud"
        "Pictures"
        "Sync"
        "Videos"
        { directory = ".config/Keybase"; mode = "0700"; }
        { directory = ".gnupg"; mode = "0700"; }
        { directory = ".local/share/keybase"; mode = "0700"; }
        { directory = ".secrets"; mode = "0700"; }
        { directory = ".ssh"; mode = "0700"; }
      ];
      files = [
        ".cache/keybasekeybase.app.serverConfig"
        ".netrc"
      ];
    };
  };

  # Not important but persistent files
  environment.persistence."/var/residues" = {
    hideMounts = true;
    directories = [
      "/var/cache"
      "/var/log"
    ];
    users.nico = {
      directories = [
        ".cache/chromium"
        ".cache/keybase"
        ".cache/mesa_shader_cache"
        ".cache/mozilla"
        ".cache/nix-index"
        ".cache/spotify"
        ".cache/thunderbird"
        ".local/share/Trash"
        ".local/state/wireplumber"
        ".lyrics"
        ".steam"
      ];
    };
  };

  # Shadow can't be added to persistent
  #users.users."root".passwordFile = "/var/persistent/secrets/shadow/root";
  #users.users."nico".passwordFile = "/var/persistent/secrets/shadow/pedrohlc";
}
