{ ... }:

let
  aliases = {
    ll = "ls -la";
    ".." = "cd ..";
    rebuild = "sudo nixos-rebuild switch --flake .";
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
