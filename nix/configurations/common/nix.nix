{ pkgs, config, sources, lib, ... }:
{
  # General nix settings
  nix = {
    # Do garbage collections whenever there is less than 1GB free space left
    extraOptions = ''
      min-free = ${toString (1024 * 1024 * 1024)}
    '';
    # Do daily garbage collections
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
    settings = {
      # Only allow the wheel group to handle Nix
      allowed-users = [ "@wheel" ];
      # Allow using flakes
      auto-optimise-store = true;
      # github:nix-community/* cache
      extra-substituters = [
        "https://nix-community.cachix.org"
        "https://garuda-linux.cachix.org"
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "garuda-linux.cachix.org-1:tWw7YBE6qZae0L6BbyNrHo8G8L4sHu5QoDp0OXv70bg="
      ];
      # This is a flake after all
      experimental-features = [ "nix-command" "flakes" ];
      max-jobs = "auto";
      system-features = [ "kvm" "big-parallel" ];
      trusted-users = [ "root" "nico" ];
    };
    nixPath = [ "nixpkgs=${sources.nixpkgs}" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Clean results periodically
  systemd.services.nix-clean-result = {
    serviceConfig.Type = "oneshot";
    description =
      "Auto clean all result symlinks created by nixos-rebuild test";
    script = ''
      "${config.nix.package.out}/bin/nix-store" --gc --print-roots | "${pkgs.gawk}/bin/awk" 'match($0, /^(.*\/result) -> \/nix\/store\/[^-]+-nixos-system/, a) { print a[1] }' | xargs -r -d\\n rm
    '';
    before = [ "nix-gc.service" ];
    wantedBy = [ "nix-gc.service" ];
  };

  # Print a diff when running system updates
  system.activationScripts.diff = ''
    if [[ -e /run/current-system ]]; then
      (
        for i in {1..3}; do
          result=$(${config.nix.package}/bin/nix store diff-closures /run/current-system "$systemConfig" 2>&1)
          if [ $? -eq 0 ]; then
            printf '%s' "$result"
            break
          fi
        done
      )
    fi
  '';
}
