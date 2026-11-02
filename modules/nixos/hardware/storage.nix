{ config, lib, ... }:

let
  cfg = config.my.hardware.storage;
in
{
  options.my.hardware.storage.enable = lib.mkEnableOption "fstrim, SMART monitoring and udisks2";

  config = lib.mkIf cfg.enable {
    services.fstrim.enable = true;
    services.smartd.enable = true;
    services.udisks2.enable = true;
  };
}
