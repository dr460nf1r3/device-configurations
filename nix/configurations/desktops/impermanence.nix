# ZFS-based impermanence but instead of rolling back on every start, roll back on safe shutdown/halt/reboot
{ config, lib, pkgs, ... }: 
let
  cfgZfs = config.boot.zfs;
in
{
  # Reset rootfs on shutdown
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
      "/var/cache/chaotic"
      "/var/lib/bluetooth"
      "/var/lib/containers"
      "/var/lib/flatpak"
      "/var/lib/systemd"
      "/var/lib/upower"
      "/var/lib/vnstat"
      # "/var/lib/waydroid"
      "/var/lib/zerotier-one"
      { directory = "/var/lib/iwd"; mode = "u=rwx,g=,o="; }
    ];
    files = [
      "/etc/machine-id"
    ];
    users.root = {
      home = "/root";
      directories = [
        { directory = ".gnupg"; mode = "0700"; }
        { directory = ".ssh"; mode = "0700"; }
      ];
    };
    users.nico = {
      directories = [
        ".android"
        ".ansible"
        ".config/Code"
        ".config/GitKraken"
        ".config/JetBrains"
        ".config/Nextcloud"
        ".config/PulseEffects"
        ".config/Termius"
        ".config/VirtualBox"
        ".config/asciinema"
        ".config/chromium"
        ".config/discord"
        ".config/evolution"
        ".config/goa-1.0"
        ".config/gsconnect"
        ".config/lutris"
        ".config/obs-studio"
        ".config/spotify-tui"
        ".config/teams-for-linux"
        ".gitkraken"
        ".java"
        ".local/share/JetBrains"
        ".local/share/Nextcloud"
        ".local/share/Steam"
        ".local/share/TelegramDesktop"
        ".local/share/Vorta"
        ".local/share/containers"
        ".local/share/evolution"
        ".local/share/fish"
        ".local/share/gnome-photos"
        ".local/share/gnome-remote-desktop"
        ".local/share/gvfs-metadata"
        ".local/share/heroku"
        ".local/share/lutris"
        ".local/share/nautilus"
        ".local/share/PrismLauncher"
        ".local/share/tor-browser"
        # ".local/share/waydroid"
        ".mozilla"
        ".thunderbird"
        ".var"
        "Documents"
        "Downloads"
        "Music"
        "Nextcloud"
        "Pictures"
        "Sync" 
        "Videos"
        { directory = ".config/Bitwarden CLI"; mode = "0700"; }
        { directory = ".config/Keybase"; mode = "0700"; }
        { directory = ".gnupg"; mode = "0700"; }
        { directory = ".local/share/keybase"; mode = "0700"; }
        { directory = ".local/share/keyrings"; mode = "0700"; }
        { directory = ".secrets"; mode = "0700"; }
        { directory = ".ssh"; mode = "0700"; }
        { directory = ".yubico"; mode = "0700"; }
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
        ".cache/evolution"
        ".cache/keybase"
        ".cache/lutris"
        ".cache/mesa_shader_cache"
        ".cache/nix-index"
        ".cache/spotify"
        ".cache/thunderbird"
        ".cache/tracker3"
        ".local/share/Trash"
        ".local/state/wireplumber"
        ".steam"
      ];
    };
  };
}
