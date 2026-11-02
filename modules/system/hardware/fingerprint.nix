{ config, lib, ... }:

let
  cfg = config.my.hardware.fingerprint;
in
{
  options.my.hardware.fingerprint.enable = lib.mkEnableOption "fingerprint reader (fprintd)";

  config = lib.mkIf cfg.enable {
    services.fprintd.enable = true;
  };
}
