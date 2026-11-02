{ config, lib, ... }:

{
  options.my.services.ssh.enable = lib.mkEnableOption "the OpenSSH server (no root login)";

  config = lib.mkIf config.my.services.ssh.enable {
    services.openssh = {
      enable = true;
      settings.PermitRootLogin = "no";
    };
  };
}
