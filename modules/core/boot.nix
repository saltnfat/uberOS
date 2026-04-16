{
  pkgs,
  config,
  lib,
  host,
  ...
}:

let
  inherit (config.uberOS)
    securebootEnable
    nvmePowerFixEnable
    pcieASPMDisable
    gpuProfile
    ;
  inherit (pkgs.stdenv.hostPlatform) isx86_64 isAarch64;

  extraModprobeConfig =
    if gpuProfile == "nvidia" then
      ''
        blacklist nouveau
        blacklist nova_core
        options nouveau modeset=0
      ''
    else
      "";

  blacklistedKernelModules = if gpuProfile == "nvidia" then [ "nouveau" ] else [ ];
in
{

  # select which linux kernel to use
  #boot.kernelPackages = if isx86_64 then pkgs.linuxPackages_latest else pkgs.linuxPackages;
  boot.kernelPackages = if isx86_64 then pkgs.linuxPackages_zen else pkgs.linuxPackages;

  # Bootloader
  boot.loader.systemd-boot = lib.mkMerge [
    (lib.mkIf (securebootEnable == true) {
      enable = lib.mkForce false;
    })
    (lib.mkIf (securebootEnable == false) {
      enable = true;
    })
  ];

  boot.lanzaboote = lib.mkIf (securebootEnable == true) {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642;
    "vm.swappiness" = 10;
  };

  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "25%";

  # This is for OBS Virtual Cam Support - v4l2loopback setup
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

  # Blacklist certain modules if using dedicated Nvidia gpu only
  boot.extraModprobeConfig = extraModprobeConfig;
  boot.blacklistedKernelModules = blacklistedKernelModules;

  boot.kernelParams = lib.mkMerge [
    (lib.mkIf (nvmePowerFixEnable == true) [ "nvme_core.default_ps_max_latency_us=0" ])
    (lib.mkIf (pcieASPMDisable == true) [ "pcie_aspm=off" ])
    (lib.mkIf (pcieASPMDisable == true) [ "pcie_port_pm=off" ])
    #(lib.mkIf (pcieASPMDisable == true) [ "nvme.noacpi=1" ])
    #(lib.mkIf (gpuProfile == "nvidia") [ "mem_sleep_default=s2idle" ])
    (lib.mkIf (gpuProfile == "nvidia") [ "module_blacklist=amdgpu" ])
  ];

  # Appimage support
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };
}
