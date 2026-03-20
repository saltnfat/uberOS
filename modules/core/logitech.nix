{
  pkgs,
  config,
  lib,
  host,
  ...
}:

let
  inherit (config.uberOS) logitechEnable;
in
lib.mkIf (logitechEnable == true) {
  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;
}
