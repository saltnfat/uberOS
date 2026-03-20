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
    # You can get this by running - mkpasswd -m sha-512 <password>
    hashedPassword = "$6$edpk.us5k8TGExLh$f3Q6AhZtLGXcOOOmnyUE7CSOMAmB0219Vgw1gbQkXE49M53XRYP7eRbiH9p84nsYjwBHsmrJVUB0Tm1YeS4AS.";
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
