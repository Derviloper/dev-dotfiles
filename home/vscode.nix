{ pkgsUnstable, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgsUnstable.vscode;
  };
}
