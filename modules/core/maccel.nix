{
  inputs,
  host,
  config,
  ...
}:
let
  inherit (config.uberOS) username;
in
{
  imports = [
    inputs.maccel.nixosModules.default
  ];

  hardware.maccel = {
    enable = true;
    enableCli = true; # Optional

    parameters = {
      # Common (all modes)
      sensMultiplier = 1.2; # default 1.0
      yxRatio = 2.00; # default 1.0
      inputDpi = 3200.0; # default 1000.0
      angleRotation = 1.0; # default 0.0
      mode = "linear"; # "synchronous"

      # default values
      # sensMultiplier = 1.0;
      # yxRatio = 1.0;
      # inputDpi = 1000.0;
      # angleRotation = 0.0;
      # mode = "synchronous";

      # Linear mode
      acceleration = 0.02;
      offset = 0.2;
      outputCap = 8.0;

      # # Natural mode
      # decayRate = 0.1;
      # offset = 2.0;
      # limit = 1.5;

      # # Synchronous mode
      # gamma = 1.0;
      # smooth = 0.5;
      # motivity = 2.5;
      # syncSpeed = 10.0;
    };
  };

  # To use maccel CLI/TUI without sudo
  users.groups.maccel.members = [ "${username}" ];
}
