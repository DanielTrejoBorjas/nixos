{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.kdePackages; [
    kcalc
  ];
}
