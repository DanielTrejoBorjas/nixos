{ config, lib, ... }:

{
  options.my.services.fail2ban.enable = lib.mkEnableOption "fail2ban";

  config = lib.mkIf config.my.services.fail2ban.enable {
    services.fail2ban = {
      enable = true;
      maxretry = 5;
      bantime = "1h";
    };
  };
}
