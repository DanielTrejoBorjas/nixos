{ config, lib, pkgs, ... }:

{
  options.my.services.printing.enable = lib.mkEnableOption "CUPS printing with Gutenprint and HPLIP drivers";

  config = lib.mkIf config.my.services.printing.enable {
    my.services.avahi.enable = lib.mkDefault true; # network printer discovery

    services.printing = {
      enable = true;
      drivers = with pkgs; [ gutenprint hplip ];
    };
  };
}
