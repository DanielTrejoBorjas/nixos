{ pkgs, ... }:

{
  imports = [ ./avahi.nix ]; # network printer discovery

  services.printing = {
    enable = true;
    drivers = with pkgs; [ gutenprint hplip ];
  };
}
