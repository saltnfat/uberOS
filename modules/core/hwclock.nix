{
  config,
  lib,
  ...
}:

let
  inherit (config.uberOS) localHardwareClock;
in
lib.mkIf (localHardwareClock == true) {
  time.hardwareClockInLocalTime = true;
}
