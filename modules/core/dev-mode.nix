{
  pkgs,
  host,
  config,
  ...
}:
let
  flakePath = "/home/${config.uberOS.username}/uberOS";
in
{

  environment.systemPackages = with pkgs; [
    nixfmt
    nixd
    terminaltexteffects
    watchexec
    (pkgs.writeShellScriptBin "dev-mode" ''
      watchexec --restart --clear --ignore result nix flake check ${flakePath}
    '')

  ];

}
