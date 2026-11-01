{ ... }:

{
  # SSH access to the VM (handy from the Hyper-V host)
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
  };
}
