{ config, lib, ... }:

let
  cfg = config.my.boot;
in
{
  config = lib.mkIf (cfg.loader == "systemd-boot") {
    boot.loader.systemd-boot = {
      enable = true;
      configurationLimit = cfg.generationLimit;
    };
  };
}
