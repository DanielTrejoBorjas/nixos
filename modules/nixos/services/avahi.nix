{ config, lib, ... }:

{
  options.my.services.avahi.enable = lib.mkEnableOption "Avahi mDNS discovery";

  config = lib.mkIf config.my.services.avahi.enable {
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
