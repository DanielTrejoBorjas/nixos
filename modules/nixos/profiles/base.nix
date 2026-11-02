{ config, lib, ... }:

# What every host gets: the minimal system plus basic CLI programs.
# mkDefault so a host can still turn off any single part.
let
  on = lib.mkDefault true;
in
{
  options.my.profiles.base.enable = lib.mkEnableOption "the minimal bootable, reachable system with basic CLI programs";

  config = lib.mkIf config.my.profiles.base.enable {
    my.system = {
      nix.enable = on;
      memory.enable = on;
      network.enable = on;
      security.enable = on;
      journal.enable = on;
    };

    my.hardware = {
      firmware.enable = on;
      graphics.enable = on;
      storage.enable = on;
      input.enable = on;
    };

    my.shell = {
      zsh.enable = on;
      bash.enable = on;
    };

    my.apps.git.enable = on;
    my.packages.tools.enable = on;
  };
}
