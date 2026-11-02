{ ... }:

# Home Manager config for "daniel".
{
  my = {
    git.enable = true;
    editor.enable = true;
    packages.cli.enable = true;
    shell = {
      aliases.enable = true;
      bash.enable = true;
      zsh.enable = true;
    };
  };

  home.username = "daniel";
  home.homeDirectory = "/home/daniel";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  programs.git.settings.user = {
    name = "Daniel";
    email = "danieltrejoborjas@gmail.com";
  };
}
