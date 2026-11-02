{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.kdePackages; [
    elisa
  ];
}
