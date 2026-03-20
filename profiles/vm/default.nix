{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf (config.uberOS.gpuProfile == "vm") {
    # Enable GPU Drivers
    drivers.amdgpu.enable = false;
    drivers.nvidia.enable = false;
    drivers.nvidia-prime.enable = false;
    drivers.intel.enable = false;
    vm.guest-services.enable = true;
    uberOS.smartdEnable = lib.mkForce false;
  };
}
