{ config, lib, ... }:

{
  options.my.services.tailscale.enable = lib.mkEnableOption "Tailscale client";

  config = lib.mkIf config.my.services.tailscale.enable {
    services.tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };

    networking.firewall.checkReversePath = "loose";
  };
}
