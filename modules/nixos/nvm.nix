{ pkgs, ... }:
let
  nvm = pkgs.fetchFromGitHub {
    owner = "nvm-sh";
    repo = "nvm";
    rev = "v0.40.3";
    hash = "sha256-s36EQojnNKm4x410nllC3nbnzzwcLZCKSP3DkJPpjjo=";
  };
in
{
  programs.zsh.interactiveShellInit = ''
    export NVM_DIR="$HOME/.nvm"
    [ -s "${nvm}/nvm.sh" ] && \. "${nvm}/nvm.sh"
    [ -s "${nvm}/bash_completion" ] && \. "${nvm}/bash_completion"
  '';
}
