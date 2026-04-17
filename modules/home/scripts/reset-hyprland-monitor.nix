{ pkgs }:
pkgs.writeShellScriptBin "reset-hyprland-monitor" ''
  #!${pkgs.bash}/bin/bash

  hyprctl keyword monitor DP-3, 3440x1440@174.96, auto, 1, bitdepth, 10, cm, srbg, sdrbrightness, 1.15, sdrsaturation, 0.80, vrr, 3
  hyprctl keyword monitor DP-3, 3440x1440@174.96, auto, 1, bitdepth, 10, cm, hdredid, sdrbrightness, 1.15, sdrsaturation, 0.80, vrr, 3

''
