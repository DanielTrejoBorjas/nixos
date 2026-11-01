{ ... }:

let
  aliases = {
    ll = "ls -la";
    ".." = "cd ..";
    rebuild = "rebuild() { sudo nixos-rebuild switch --flake .\${1:+#\$1}; }; rebuild";
  };
in
{
  programs.bash = {
    enable = true;
    shellAliases = aliases;
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;
    shellAliases = aliases;
  };
}
