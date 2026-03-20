{
  host,
  inputs,
  config,
  options,
  ...
}:
let
  inherit (config.uberOS) hostname;
in
{
  networking = {
    hostName = "${hostname}"; # Define your hostname
    networkmanager.enable = true;
    hosts = {
      "192.168.8.165" = [ "nix-lappy" ];
      "192.168.8.179" = [ "nix-deskstar" ];
    };
    nat = {
      enable = true;
      internalInterfaces = [ "virbr0" ];
    };
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
    firewall = {
      enable = false;
      allowedTCPPorts = [
        8384
        22000
        3000
        465 # gmail smtp
      ];
      allowedUDPPorts = [
        22000
        21027
      ];
      trustedInterfaces = [ "virbr0" ];
    };
  };
}
