{ config, lib, ... }:

# Shared git defaults. Identity (name/email) is set per user in users/<name>/home.nix.
{
  options.my.git.enable = lib.mkEnableOption "git with shared defaults";

  config = lib.mkIf config.my.git.enable {
    programs.git = {
      enable = true;
      settings = {
        init.defaultBranch = "main";
        pull.rebase = true;
        push.autoSetupRemote = true;
        rebase.autoStash = true;
        fetch.prune = true;
      };
    };
  };
}
