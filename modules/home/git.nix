{
  uberOS,
  ...
}:
let
  inherit (uberOS)
    gitUsername
    gitEmail
    username
    gpgSigningKeyId
    ;
in
{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "${gitUsername}";
        email = "${gitEmail}";
        signingKey = "${gpgSigningKeyId}";
      };
      core = {
        editor = "nvim";
        pager = "delta";
      };
      signing = {
        signByDefault = true;
        format = "openpgp";
      };
      log = {
        decorate = "full"; # Show branch/tag info in git log
        date = "iso"; # ISO 8601 date format
        showSignature = true;
      };
      commit.gpgsign = true;
      tag.gpgSign = true;

      # FOSS-friendly settings
      push.default = "simple"; # Match modern push behavior
      credential.helper = "cache --timeout=7200";
      # Conflict resolution style for readable diffs
      merge.conflictStyle = "diff3";

      # Optional: FOSS-friendly Git aliases
      alias = {
        br = "branch --sort=-committerdate";
        co = "checkout";
        df = "diff";
        com = "commit -a";
        gs = "stash";
        gp = "pull";
        lg = "log --graph --pretty=format:'%Cred%h%Creset - %C(yellow)%d%Creset %s %C(green)(%cr)%C(bold blue) <%an>%Creset' --abbrev-commit";
        st = "status";
      };
    };
  };
}
