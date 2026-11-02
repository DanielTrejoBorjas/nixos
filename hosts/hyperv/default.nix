{ ... }:

# Everything this machine runs. Profiles enable groups with mkDefault, so any
# single module can still be switched off here, e.g. my.apps.kate.enable = false.
{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "hyperv";

  my = {
    profiles = {
      base.enable = true;
      plasma.enable = true;
      plasma-apps.enable = true;
    };

    audio.backend = "pipewire";
    virtualization.guest = "hyperv";

    services.ssh.enable = true;

    # null keeps Plasma's own appearance; see themes/ for the available names.
    theme.name = null;
  };

  system.stateVersion = "25.11";
}
