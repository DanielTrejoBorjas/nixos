{ ... }:

# Home Manager config for "daniel".
{
  imports = [
    ../../modules/home
  ];

  home.username = "daniel";
  home.homeDirectory = "/home/daniel";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  programs.git.settings.user = {
    name = "Daniel";
    email = "danieltrejoborjas@gmail.com";
  };
}
