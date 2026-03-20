{
  uberOS,
  host,
  inputs,
  ...
}:
let
  inherit (uberOS) username hostname;
in
{

  sops.defaultSopsFile = ./../../secrets/secrets.yaml;
  #sops.defaultSopsFile = ./../../${hostname}/secrets/secrets.yaml;
  sops.age.sshKeyPaths = [ "/home/${username}/.ssh/id_ed25519" ];
  sops.secrets."syncthing/${hostname}/cert.pem" = { };
  sops.secrets."syncthing/${hostname}/key.pem" = { };
  sops.secrets.git = { };
  sops.secrets."gpg/${username}/signing" = { };
  systemd.user.services.mbsync.Unit.After = [ "sops-nix.service" ];
}
