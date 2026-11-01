{ ... }:

# Shared git defaults. Identity (name/email) is set per user in users/<name>/home.nix.
{
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
