[![built with nix](https://img.shields.io/static/v1?logo=nixos&logoColor=white&label=&message=Built%20with%20Nix&color=41439a)](https://builtwithnix.org)

# My personal NixOS flake & system configurations

This repo contains my NixOS dotfiles. All of my personal devices are going to be added here over time.

![desktop](https://i.imgur.com/XdwFOrP.png)

**What is inside?**:

- Multiple **NixOS configurations**, including **desktop**, **laptop**, **server**
- **Opt-in persistence** through impermanence + ZFS snapshots
- **Mesh networked** hosts with **zerotier**
- Fully themed & configured operating system using **Stylix** & the GNOME desktop

## Structure

- `flake.nix`: Entrypoint for hosts and home configurations. Also exposes a
  devshell for boostrapping (`nix develop` or `nix-shell`).
- `hosts`: NixOS Configurations, accessible via `nixos-rebuild --flake`.
- `apps`: Packages built from source
- `overlays`: Patches and version overrides for some packages.
- `pkgs`: My custom packages.

## How to bootstrap

All you need is nix (any version). Run:

```
nix-shell
```

If you already have nix 2.4+, git, and have already enabled `flakes` and
`nix-command`, you can also use the non-legacy command:

```
nix develop
```

`nixos-rebuild --flake .` To build system configurations
`home-manager --flake .` To build user configurations

## Credits

A special thanks to [PedroHLC](https://github.com/pedrohlc)
and [Mysterio77](https://github.com/Misterio77), their Nix
configurations helped tremendously while setting all of this up.
