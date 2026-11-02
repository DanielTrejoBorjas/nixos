{ ... }:

# Applies to every shell enabled in this directory.
{
  home.shellAliases = {
    ll = "ls -la";
    ".." = "cd ..";
    rebuild = "rebuild() { sudo nixos-rebuild switch --flake .\${1:+#\$1}; }; rebuild";
  };
}
