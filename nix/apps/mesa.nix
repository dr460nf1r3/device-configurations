{ pkgs, lib, flakeInputs, ... }:
let
  # future = nixpkgs-staging.legacyPackages.${pkgs.system};

  dropN = n: list: lib.lists.take (builtins.length list - n) list;

  mesaGitApplier = base: base.mesa.overrideAttrs (fa: {
    version = "23.1.99";
    src = flakeInputs.mesa-git-src;
    buildInputs = fa.buildInputs ++ [ base.libunwind base.lm_sensors ];
    mesonFlags =
      lib.lists.remove "-Dgallium-rusticl=true" fa.mesonFlags # fails to find "valgrind.h"
      ++ [ "-Dandroid-libbacktrace=disabled" ];
  });

  mesa-bleeding = mesaGitApplier pkgs;
  lib32-mesa-bleeding = mesaGitApplier pkgs.pkgsi686Linux;
in
{
  # Apply latest mesa in the system
  hardware.opengl.package = mesa-bleeding.drivers;
  hardware.opengl.package32 = lib32-mesa-bleeding.drivers;
  hardware.opengl.extraPackages = [ mesa-bleeding.opencl ];

  # Creates a second boot entry without latest drivers
  specialisation.stable-mesa.configuration = {
    system.nixos.tags = [ "stable-mesa" ];
    hardware.opengl.package = lib.mkForce pkgs.mesa.drivers;
    hardware.opengl.package32 = lib.mkForce pkgs.pkgsi686Linux.mesa.drivers;
  };
}
