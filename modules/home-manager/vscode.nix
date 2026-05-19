{
  homeDirectory,
  lib,
  pkgs,
  ...
}:
{
  home.activation.seedVscodeArgv = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    target="${homeDirectory}/.vscode/argv.json"
    source=${lib.escapeShellArg (
      pkgs.writeText "argv.json" ''
        {
          "password-store": "gnome-libsecret"
        }
      ''
    )}

    if [ ! -e "$target" ]; then
      run mkdir -p "$(dirname "$target")"
      run install -m 0644 "$source" "$target"
    fi
  '';
}
