{ config, lib, ... }:

let
  cfg = config.my.system.journal;
in
{
  options.my.system.journal.enable = lib.mkEnableOption "journald size and retention limits";

  config = lib.mkIf cfg.enable {
    services.journald.settings = {
      Journal = {
        SystemMaxUse = "500M";
        MaxRetentionSec = "1month";
      };
    };
  };
}
