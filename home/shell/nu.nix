{ ... }:

{
    programs.nushell = {
        enable = true;
        extraConfig = ''$env.PATH ++= [ "~/.nix-profile/bin" ]'';
    };
}
