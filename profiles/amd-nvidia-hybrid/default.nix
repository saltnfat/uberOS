{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.uberOS.gpuProfile == "amd-nvidia-hybrid") {
    # Enable AMD+NVIDIA hybrid drivers (Prime offload with AMD as primary)
    drivers.nvidia-amd-hybrid = {
      enable = true;
      amdgpuBusId = config.uberOS.amdgpuID;
      nvidiaBusId = config.uberOS.nvidiaID;
    };

    # Ensure other driver toggles are off for this profile
    drivers.amdgpu.enable = false;
    drivers.nvidia.enable = false;
    drivers.nvidia-prime.enable = false;
    drivers.intel.enable = false;

    vm.guest-services.enable = false;
  };
}
