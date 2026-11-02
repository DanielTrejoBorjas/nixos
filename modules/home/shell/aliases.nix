{ config, lib, ... }:

# Applies to every shell Home Manager manages.
{
  options.my.shell.aliases.enable = lib.mkEnableOption "shared shell aliases";

  config = lib.mkIf config.my.shell.aliases.enable {
    home.shellAliases = {
      ll = "ls -la";
      ".." = "cd ..";
      rebuild = "rebuild() { sudo nixos-rebuild switch --flake .\${1:+#\$1}; }; rebuild";
    };
  };
}
