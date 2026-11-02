{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.kdePackages; [
    spectacle
  ];
}
