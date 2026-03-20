{ ... }:
{
  imports = [
    ./amd-drivers.nix
    ./intel-drivers.nix
    ./nvidia-drivers.nix
    ./nvidia-prime-drivers.nix
    ./nvidia-amd-hybrid.nix
    ./vm-guest-services.nix
  ];
}
