{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.uberOS.gpuProfile == "nvidia-laptop") {
    # Enable GPU Drivers
    drivers.amdgpu.enable = false;
    drivers.nvidia.enable = true;
    drivers.nvidia-prime = {
      enable = true;
      intelBusID = config.uberOS.intelID;
      nvidiaBusID = config.uberOS.nvidiaID;
    };
    drivers.intel.enable = false;
    vm.guest-services.enable = false;
  };
}
