{
  pkgs,
  config,
  lib,
  host,
  ...
}:

let
  inherit (config.uberOS) kdeEnable;
in
lib.mkIf (kdeEnable == true) {
  services.desktopManager.plasma6.enable = true;
}
