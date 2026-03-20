{
  pkgs,
  config,
  lib,
  host,
  ...
}:

let
  inherit (config.uberOS) gpuProfile;
in
lib.mkIf (gpuProfile == "nvidia") {
  # GPU overclock/tuning tool (like MSI Afterburner)
  services.lact = {
    enable = true;
    # settings = {
    #
    # };
  };
}
