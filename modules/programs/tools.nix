{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    htop
    tree
    unzip
  ];
}
