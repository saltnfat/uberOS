{
  pkgs,
  config,
  username,
  host,
  inputs,
  ...
}:

let
  inherit (config.uberOS) gitUsername shell;
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {
      inherit
        inputs
        username
        host
        pkgs
        # attempting to pass config to HM will break it
        # config
        ;
      inherit (config) uberOS;
    };
    users.${username} = {
      imports = [
        ./../home
        inputs.dms.homeModules.dank-material-shell
        inputs.sops-nix.homeManagerModules.sops
      ];
      home = {
        username = "${username}";
        homeDirectory = "/home/${username}";
        stateVersion = "25.11";
      };
    };
  };
  users.mutableUsers = true;
  users.users."${username}" = {
    isNormalUser = true;
    description = "${gitUsername}";
    extraGroups = [
      "networkmanager"
      "docker" # access to docker as non-root
      "wheel" # sudo access
      "libvirtd" # virt-manager / qemu
      "video"
    ];
    shell = pkgs.${shell};
    ignoreShellProgramCheck = true;
  };
  nix.settings.allowed-users = [ "${username}" ];

}
