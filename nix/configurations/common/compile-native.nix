{ ... }:
{
  # I might try to recompile the whole system for generic_v3?
  nixpkgs.localSystem = {
    gcc.arch = "native";
    gcc.tune = "native";
    system = "x86_64-linux";
  };
}
