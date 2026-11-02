{ config, lib, ... }:

let
  cfg = config.my.hardware.nvidia;
in
{
  imports = [
    ./nouveau.nix
    ./proprietary.nix
  ];

  options.my.hardware.nvidia = {
    enable = lib.mkEnableOption "NVIDIA GPU support";

    driver = lib.mkOption {
      type = lib.types.enum [ "proprietary" "nouveau" ];
      default = "proprietary";
      description = "Proprietary NVIDIA driver or the free in-kernel nouveau driver.";
    };

    variant = lib.mkOption {
      type = lib.types.enum [
        "stable"
        "latest"
        "production"
        "beta"
        "legacy_580"
        "legacy_535"
        "legacy_470"
        "legacy_390"
      ];
      default = "stable";
      description = ''
        Proprietary driver branch. Current GPUs: stable/latest/production/beta.
        Older GPUs: legacy_580 (Maxwell/Pascal/Volta), legacy_535,
        legacy_470 (Kepler), legacy_390 (Fermi). Check the NVIDIA
        driver-support page for the branch that matches your card.
      '';
    };

    open = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Use the open kernel modules. Only for Turing (RTX 20xx / GTX 16xx)
        and newer; must stay false for legacy branches.
      '';
    };

    prime = {
      enable = lib.mkEnableOption "PRIME offload for hybrid (iGPU + NVIDIA) laptops";
      nvidiaBusId = lib.mkOption { type = lib.types.str; default = ""; example = "PCI:1:0:0"; };
      intelBusId = lib.mkOption { type = lib.types.str; default = ""; example = "PCI:0:2:0"; };
      amdgpuBusId = lib.mkOption { type = lib.types.str; default = ""; example = "PCI:6:0:0"; };
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = !(cfg.open && lib.hasPrefix "legacy_" cfg.variant);
        message = "my.hardware.nvidia.open cannot be used with legacy driver branches.";
      }
      {
        assertion = !(cfg.prime.enable && cfg.driver != "proprietary");
        message = "my.hardware.nvidia.prime requires the proprietary driver.";
      }
      {
        assertion = !cfg.prime.enable
          || (cfg.prime.nvidiaBusId != "" && (cfg.prime.intelBusId != "" || cfg.prime.amdgpuBusId != ""));
        message = "my.hardware.nvidia.prime needs nvidiaBusId and one of intelBusId/amdgpuBusId.";
      }
    ];
  };
}
