{ uberOS, ... }:
let
  inherit (uberOS)
    oled
    ;
  lockTimeout = if oled == true then 120 else 350;
  screenTimeout = if oled == true then -1 else 1200; # 1200 is 20 min
  gracePeriod = "300";
in
{
  services = {
    hypridle = {
      enable = true;
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock --grace ${gracePeriod}"; # grace must be passed as arg, doesnt work in config lol
        };
        listener = [
          {
            timeout = lockTimeout;
            on-timeout = "hyprlock --grace ${gracePeriod}";
          }
          {
            timeout = screenTimeout;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 3600; # 1 hour
            on-timeout = "systemctl suspend";
            # script to fix washed out colors - use until hyprland fixes this issue
            on-resume = "exec reset-hyprland-monitor";
          }
        ];
      };
    };
  };
}
