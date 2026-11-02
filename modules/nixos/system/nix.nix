{ config, lib, ... }:

let
  cfg = config.my.system.nix;
in
{
  options.my.system.nix.enable = lib.mkEnableOption "flake-only Nix settings, store optimisation, GC and unfree packages";

  config = lib.mkIf cfg.enable {
    nix.settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "@wheel" ];
      warn-dirty = false;
    };

    # Flake-only: no channels, nixpkgs comes from the flake registry.
    nix.channel.enable = false;

    nix.optimise.automatic = true;

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    nixpkgs.config.allowUnfree = true;
  };
}
