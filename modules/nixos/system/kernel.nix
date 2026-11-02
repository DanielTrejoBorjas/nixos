{ config, lib, pkgs, ... }:

let
  cfg = config.my.kernel;

  packages = {
    lts = pkgs.linuxPackages;
    latest = pkgs.linuxPackages_latest;
    zen = pkgs.linuxPackages_zen;
    hardened = pkgs.linuxPackages_hardened;
  };
in
{
  options.my.kernel.variant = lib.mkOption {
    type = lib.types.enum (builtins.attrNames packages);
    default = "latest";
    description = "Kernel flavour: default LTS, latest mainline, Zen (desktop-tuned) or hardened.";
  };

  config.boot.kernelPackages = packages.${cfg.variant};
}
