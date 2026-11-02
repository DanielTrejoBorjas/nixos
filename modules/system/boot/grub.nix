{ config, lib, ... }:

let
  cfg = config.my.boot;
in
{
  config = lib.mkIf (cfg.loader == "grub") {
    boot.loader.grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      configurationLimit = cfg.generationLimit;
    };
  };
}
