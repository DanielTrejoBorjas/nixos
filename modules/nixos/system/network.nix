{ config, lib, ... }:

let
  cfg = config.my.system.network;
in
{
  options.my.system.network.enable = lib.mkEnableOption "NetworkManager, nftables firewall and systemd-resolved";

  config = lib.mkIf cfg.enable {
    networking.networkmanager.enable = true;
    networking.nftables.enable = true;
    networking.firewall.enable = true;

    services.resolved.enable = true;
  };
}
