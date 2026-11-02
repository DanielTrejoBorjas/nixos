{ ... }:

{
  networking.networkmanager.enable = true;
  networking.nftables.enable = true;
  networking.firewall.enable = true;

  services.resolved.enable = true;
}
