{ config, lib, pkgs, ... }:

# System-level account for "daniel".
{
  my.shell.zsh.enable = true; # login shell below

  users.users.daniel = {
    isNormalUser = true;
    description = "Daniel";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ]
      ++ lib.optional config.virtualisation.docker.enable "docker";
    shell = pkgs.zsh;
    initialPassword = "changeme";
  };
}
