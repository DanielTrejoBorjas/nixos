{ config, lib, ... }:

let
  cfg = config.my.system.memory;
in
{
  options.my.system.memory.enable = lib.mkEnableOption "zram swap and earlyoom";

  config = lib.mkIf cfg.enable {
    zramSwap.enable = true;
    services.earlyoom.enable = true;
  };
}
