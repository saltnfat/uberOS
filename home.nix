{
  username,
  inputs,
  ...
}:
{
  # Home Manager Settings
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.11";

  # Import Program Configurations
  imports = [
    ./nix-config/home
    inputs.dms.homeModules.dank-material-shell
    inputs.sops-nix.homeManagerModules.sops
  ];

  programs.home-manager.enable = true;
}
