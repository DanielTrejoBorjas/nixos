{ pkgs, ... }:

# System-level account for "daniel".
{
  users.users.daniel = {
    isNormalUser = true;
    description = "Daniel";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
    initialPassword = "changeme";
  };
}
